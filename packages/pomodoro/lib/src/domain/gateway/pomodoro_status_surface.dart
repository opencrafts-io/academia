import 'package:pomodoro/src/domain/enums/pomodoro_phase.dart';

/// Information a platform surface needs to present the active timer.
class PomodoroStatus {
  const PomodoroStatus({
    required this.sessionId,
    required this.phase,
    required this.remainingSeconds,
    required this.totalDurationSeconds,
    required this.isRunning,
    this.startAtEpochMillis,
    this.endsAtEpochMillis,
    this.todoTitle,
  });

  final String sessionId;
  final PomodoroPhase phase;
  final int remainingSeconds;
  final int totalDurationSeconds;
  final bool isRunning;
  final int? startAtEpochMillis;
  final int? endsAtEpochMillis;
  final String? todoTitle;
}

/// Shows and updates the timer on the host operating system, when supported.
abstract interface class PomodoroStatusSurface {
  Future<void> start(PomodoroStatus status);

  Future<void> update(PomodoroStatus status);

  Future<void> stop(String sessionId);
}

class DisabledPomodoroStatusSurface implements PomodoroStatusSurface {
  const DisabledPomodoroStatusSurface();

  @override
  Future<void> start(PomodoroStatus status) async {}

  @override
  Future<void> update(PomodoroStatus status) async {}

  @override
  Future<void> stop(String sessionId) async {}
}
