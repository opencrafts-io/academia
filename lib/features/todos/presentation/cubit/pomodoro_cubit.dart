import 'dart:async';

import 'package:academia/core/core.dart';
import 'package:academia/features/todos/todos.dart';
import 'package:vibration/vibration.dart';

/// Drives an in-app Pomodoro focus timer: alternating focus sessions and
/// breaks, optionally tracked against a [TodoItemEntity].
///
/// Registered as a lazy singleton so a running session survives navigation
/// away from the timer screen.
class PomodoroCubit extends SafeCubit<PomodoroState> {
  PomodoroCubit({required this.todoItemCubit})
    : super(PomodoroState.initial());

  /// Used to attribute completed focus time to the linked todo item.
  final TodoItemCubit todoItemCubit;

  Timer? _ticker;

  void start() {
    if (state.isRunning) return;
    emit(state.copyWith(isRunning: true));
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void pause() {
    _ticker?.cancel();
    emit(state.copyWith(isRunning: false));
  }

  void reset() {
    _ticker?.cancel();
    emit(
      state.copyWith(isRunning: false, remaining: state.totalDuration),
    );
  }

  /// Ends the current phase early and advances to the next one.
  void skip() => _advancePhase();

  /// Associates the running session with a todo item so progress is
  /// attributed to it. Pass `null` to detach.
  void linkTodoItem(TodoItemEntity? item) {
    emit(
      state.copyWith(
        linkedTodoItemLocalId: item?.localId,
        linkedTodoItemTitle: item?.title,
      ),
    );
  }

  void updateSettings({
    Duration? focusDuration,
    Duration? shortBreakDuration,
    Duration? longBreakDuration,
    int? sessionsBeforeLongBreak,
  }) {
    final updated = state.copyWith(
      focusDuration: focusDuration ?? state.focusDuration,
      shortBreakDuration: shortBreakDuration ?? state.shortBreakDuration,
      longBreakDuration: longBreakDuration ?? state.longBreakDuration,
      sessionsBeforeLongBreak:
          sessionsBeforeLongBreak ?? state.sessionsBeforeLongBreak,
    );

    // Only resync the visible countdown if the timer isn't already running,
    // otherwise a settings change mid-session would jump the clock.
    emit(
      state.isRunning
          ? updated
          : updated.copyWith(remaining: updated.totalDuration),
    );
  }

  void _tick() {
    final next = state.remaining - const Duration(seconds: 1);
    if (next.isNegative || next == Duration.zero) {
      // The phase completed naturally — count it as the full duration
      // rather than the stale pre-tick `state.remaining` (which is still
      // 1 second), so a completed session isn't undercounted by 1s.
      _advancePhase(remainingOverride: Duration.zero);
      return;
    }
    emit(state.copyWith(remaining: next));
  }

  void _advancePhase({Duration? remainingOverride}) {
    _ticker?.cancel();
    _vibrate();

    final effectiveRemaining = remainingOverride ?? state.remaining;
    final wasFocus = state.phase == PomodoroPhase.focus;

    // Count whatever was actually focused, including a session skipped
    // early — not just full sessions that ran to completion.
    if (wasFocus && state.linkedTodoItemLocalId != null) {
      final elapsed = state.totalDuration - effectiveRemaining;
      if (elapsed > Duration.zero) {
        todoItemCubit.addFocusedTime(
          localId: state.linkedTodoItemLocalId!,
          duration: elapsed,
        );
      }
    }

    final completed = wasFocus
        ? state.completedFocusSessions + 1
        : state.completedFocusSessions;

    final nextPhase = wasFocus
        ? (completed % state.sessionsBeforeLongBreak == 0
              ? PomodoroPhase.longBreak
              : PomodoroPhase.shortBreak)
        : PomodoroPhase.focus;

    final updated = state.copyWith(
      phase: nextPhase,
      completedFocusSessions: nextPhase == PomodoroPhase.longBreak
          ? 0
          : completed,
      isRunning: false,
    );

    emit(updated.copyWith(remaining: updated.totalDuration));
  }

  Future<void> _vibrate() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(pattern: const [0, 200, 100, 200]);
    }
  }

  @override
  Future<void> close() {
    _ticker?.cancel();
    return super.close();
  }
}
