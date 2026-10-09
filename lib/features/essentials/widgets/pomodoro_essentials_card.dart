import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material3_indicators/material3_indicators.dart';
import 'package:pomodoro/pomodoro.dart';

/// A compact Pomodoro entry point for the Essentials page.
class PomodoroEssentialsCard extends StatelessWidget {
  const PomodoroEssentialsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PomodoroCubit, PomodoroState>(
      builder: (context, state) {
        final colorScheme = Theme.of(context).colorScheme;
        final phaseColor = switch (state.phase) {
          PomodoroPhase.focus => colorScheme.primary,
          PomodoroPhase.shortBreak => colorScheme.tertiary,
          PomodoroPhase.longBreak => colorScheme.secondary,
        };
        final phaseTitle = switch (state.phase) {
          PomodoroPhase.focus => 'Focus session',
          PomodoroPhase.shortBreak => 'Short break',
          PomodoroPhase.longBreak => 'Long break',
        };
        final timeLabel = formatPomodoroCountdown(state.remaining);
        final taskTitle = state.linkedTodoItemTitle;
        final semanticLabel = state.hasSession
            ? '$phaseTitle ${state.isRunning ? 'running' : 'paused'}, '
                  '$timeLabel remaining'
                  '${taskTitle == null ? '' : ', working on $taskTitle'}. '
                  'Open Pomodoro timer.'
            : 'Pomodoro timer. Start a focus session. $timeLabel. '
                  'Open Pomodoro timer.';

        void openTimer() =>
            PomodoroTimerRoute(todoLocalID: state.linkedTodoItemLocalId)
                .push(context);

        return Semantics(
          button: true,
          label: semanticLabel,
          onTap: openTimer,
          child: ExcludeSemantics(
            child: Card.filled(
              color: colorScheme.surfaceContainerHigh,
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: openTimer,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.timer_outlined,
                                  size: 18,
                                  color: phaseColor,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Pomodoro',
                                  style: Theme.of(context).textTheme.labelLarge
                                      ?.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 220),
                              child: Text(
                                state.hasSession ? phaseTitle : 'Focus timer',
                                key: ValueKey(
                                  '${state.phase.name}-${state.hasSession}',
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 4),
                            AnimatedSize(
                              duration: const Duration(milliseconds: 220),
                              curve: Curves.easeOutCubic,
                              alignment: Alignment.topLeft,
                              child: state.hasSession
                                  ? _buildSessionDetails(
                                      context,
                                      state,
                                      taskTitle,
                                      colorScheme,
                                    )
                                  : _buildStartPrompt(
                                      context,
                                      phaseColor,
                                      colorScheme,
                                    ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      _buildCountdownRing(
                        context,
                        timeLabel,
                        state.progress.clamp(0.0, 1.0).toDouble(),
                        phaseColor,
                        colorScheme,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSessionDetails(
    BuildContext context,
    PomodoroState state,
    String? taskTitle,
    ColorScheme colorScheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          state.isRunning ? 'In progress' : 'Paused',
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: colorScheme.onSurfaceVariant),
        ),
        if (taskTitle != null) ...[
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(
                Icons.task_alt_rounded,
                size: 16,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  taskTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: colorScheme.onSurfaceVariant),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildStartPrompt(
    BuildContext context,
    Color phaseColor,
    ColorScheme colorScheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Make time for focused work',
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.play_arrow_rounded, size: 18, color: phaseColor),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                'Start focus session',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelLarge
                    ?.copyWith(color: phaseColor, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCountdownRing(
    BuildContext context,
    String timeLabel,
    double progress,
    Color phaseColor,
    ColorScheme colorScheme,
  ) {
    return SizedBox(
      width: 92,
      height: 92,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(end: progress),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutCubic,
              builder: (context, value, _) => WavyCircularProgressIndicator(
                value: value,
                size: 92,
                amplitude: 1.5,
                frequency: 8,
                strokeWidth: 6,
                backgroundColor: phaseColor.withAlpha(30),
                color: phaseColor,
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: Text(
              timeLabel,
              key: ValueKey(timeLabel),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
