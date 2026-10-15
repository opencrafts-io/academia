import 'package:pomodoro/src/domain/enums/pomodoro_phase.dart';

/// Durable snapshot used to reconstruct a timer after the app is restarted.
class PomodoroSessionSnapshot {
  const PomodoroSessionSnapshot({
    required this.phase,
    required this.remainingSeconds,
    required this.isRunning,
    required this.completedFocusSessions,
    required this.focusDurationSeconds,
    required this.shortBreakDurationSeconds,
    required this.longBreakDurationSeconds,
    required this.sessionsBeforeLongBreak,
    this.endsAtEpochMillis,
    this.sessionId,
    this.linkedTodoLocalId,
  });

  final PomodoroPhase phase;
  final int remainingSeconds;
  final bool isRunning;
  final int? endsAtEpochMillis;
  final int completedFocusSessions;
  final int focusDurationSeconds;
  final int shortBreakDurationSeconds;
  final int longBreakDurationSeconds;
  final int sessionsBeforeLongBreak;
  final String? sessionId;
  final int? linkedTodoLocalId;
}

/// Stores one Pomodoro timer snapshot in the host application's local store.
abstract interface class PomodoroSessionStore {
  Future<PomodoroSessionSnapshot?> read();

  Future<void> write(PomodoroSessionSnapshot snapshot);
}

class DisabledPomodoroSessionStore implements PomodoroSessionStore {
  const DisabledPomodoroSessionStore();

  @override
  Future<PomodoroSessionSnapshot?> read() async => null;

  @override
  Future<void> write(PomodoroSessionSnapshot snapshot) async {}
}
