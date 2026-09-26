import 'package:academia/features/todos/todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Full-screen Pomodoro focus timer. When [todoLocalId] is given, the
/// running session is attributed to that todo item; otherwise it's a
/// freestanding session.
class PomodoroTimerScreen extends StatefulWidget {
  const PomodoroTimerScreen({super.key, this.todoLocalId});

  final int? todoLocalId;

  @override
  State<PomodoroTimerScreen> createState() => _PomodoroTimerScreenState();
}

class _PomodoroTimerScreenState extends State<PomodoroTimerScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      // Always resolve the link from this screen's own todoLocalId —
      // PomodoroCubit is a singleton, so without this a freestanding
      // session (todoLocalId == null) would silently inherit whatever
      // todo item a previous session left linked.
      final item = widget.todoLocalId == null
          ? null
          : context
                .read<TodoItemCubit>()
                .state
                .currentItems
                .where((i) => i.localId == widget.todoLocalId)
                .firstOrNull;
      context.read<PomodoroCubit>().linkTodoItem(item);
    });
  }

  Color _phaseColor(ColorScheme scheme, PomodoroPhase phase) => switch (phase) {
    PomodoroPhase.focus => scheme.primary,
    PomodoroPhase.shortBreak => scheme.tertiary,
    PomodoroPhase.longBreak => scheme.secondary,
  };

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void _openSettings(BuildContext context, PomodoroState state) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) => PomodoroSettingsSheet(
        focusDuration: state.focusDuration,
        shortBreakDuration: state.shortBreakDuration,
        longBreakDuration: state.longBreakDuration,
        sessionsBeforeLongBreak: state.sessionsBeforeLongBreak,
        onSave:
            ({
              required focusDuration,
              required shortBreakDuration,
              required longBreakDuration,
              required sessionsBeforeLongBreak,
            }) {
              context.read<PomodoroCubit>().updateSettings(
                focusDuration: focusDuration,
                shortBreakDuration: shortBreakDuration,
                longBreakDuration: longBreakDuration,
                sessionsBeforeLongBreak: sessionsBeforeLongBreak,
              );
            },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return BlocBuilder<PomodoroCubit, PomodoroState>(
      builder: (context, state) {
        final color = _phaseColor(scheme, state.phase);
        final cubit = context.read<PomodoroCubit>();

        return Scaffold(
          appBar: AppBar(
            title: Text(state.phase.label),
            actions: [
              IconButton(
                icon: const Icon(Icons.tune),
                onPressed: () => _openSettings(context, state),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                if (state.linkedTodoItemTitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Column(
                      children: [
                        Chip(
                          avatar: const Icon(
                            Icons.checklist_rounded,
                            size: 16,
                          ),
                          label: Text(
                            "Focusing on: ${state.linkedTodoItemTitle}",
                          ),
                        ),
                        const SizedBox(height: 4),
                        _buildTrackedTime(context, state),
                      ],
                    ),
                  ),
                const Spacer(),
                _buildRing(context, state, color),
                const SizedBox(height: 24),
                _buildSessionDots(state, color),
                const Spacer(),
                _buildControls(context, cubit, state, color),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTrackedTime(BuildContext context, PomodoroState state) {
    return BlocBuilder<TodoItemCubit, TodoItemState>(
      builder: (context, todoState) {
        final item = todoState.currentItems
            .where((i) => i.localId == state.linkedTodoItemLocalId)
            .firstOrNull;
        if (item == null || item.focusedSeconds == 0) {
          return const SizedBox.shrink();
        }
        return Text(
          "Total tracked: "
          "${formatFocusedDuration(Duration(seconds: item.focusedSeconds))}",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        );
      },
    );
  }

  Widget _buildRing(BuildContext context, PomodoroState state, Color color) {
    return SizedBox(
      width: 260,
      height: 260,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 260,
            height: 260,
            child: CircularProgressIndicator(
              value: state.progress.clamp(0, 1),
              strokeWidth: 10,
              strokeCap: StrokeCap.round,
              backgroundColor: color.withAlpha(30),
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _formatDuration(state.remaining),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                state.isRunning ? "Running" : "Paused",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: color.withAlpha(180)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSessionDots(PomodoroState state, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(state.sessionsBeforeLongBreak, (i) {
        final filled = i < state.completedFocusSessions;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: filled ? color : color.withAlpha(40),
          ),
        );
      }),
    );
  }

  Widget _buildControls(
    BuildContext context,
    PomodoroCubit cubit,
    PomodoroState state,
    Color color,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton.filledTonal(
          iconSize: 28,
          onPressed: cubit.reset,
          icon: const Icon(Icons.replay_rounded),
        ),
        const SizedBox(width: 24),
        IconButton.filled(
          iconSize: 40,
          style: IconButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(20),
          ),
          onPressed: state.isRunning ? cubit.pause : cubit.start,
          icon: Icon(
            state.isRunning
                ? Icons.pause_rounded
                : Icons.play_arrow_rounded,
          ),
        ),
        const SizedBox(width: 24),
        IconButton.filledTonal(
          iconSize: 28,
          onPressed: cubit.skip,
          icon: const Icon(Icons.skip_next_rounded),
        ),
      ],
    );
  }
}
