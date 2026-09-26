import 'package:academia/features/todos/todos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'pomodoro_state.freezed.dart';

@freezed
abstract class PomodoroState with _$PomodoroState {
  const PomodoroState._();

  const factory PomodoroState({
    required PomodoroPhase phase,
    required Duration remaining,
    @Default(false) bool isRunning,

    /// Number of focus sessions completed in the current cycle, reset
    /// after every long break.
    @Default(0) int completedFocusSessions,

    @Default(Duration(minutes: 25)) Duration focusDuration,
    @Default(Duration(minutes: 5)) Duration shortBreakDuration,
    @Default(Duration(minutes: 15)) Duration longBreakDuration,

    /// How many focus sessions happen before a long break is taken.
    @Default(4) int sessionsBeforeLongBreak,

    /// The todo item this session is tracking time against, if any.
    int? linkedTodoItemLocalId,
    String? linkedTodoItemTitle,
  }) = _PomodoroState;

  factory PomodoroState.initial() => const PomodoroState(
    phase: PomodoroPhase.focus,
    remaining: Duration(minutes: 25),
  );

  Duration get totalDuration => switch (phase) {
    PomodoroPhase.focus => focusDuration,
    PomodoroPhase.shortBreak => shortBreakDuration,
    PomodoroPhase.longBreak => longBreakDuration,
  };

  double get progress => totalDuration.inSeconds == 0
      ? 0
      : 1 - (remaining.inSeconds / totalDuration.inSeconds);
}
