enum PomodoroPhase { focus, shortBreak, longBreak }

extension PomodoroPhaseX on PomodoroPhase {
  String get label => switch (this) {
    PomodoroPhase.focus => "Focus",
    PomodoroPhase.shortBreak => "Short break",
    PomodoroPhase.longBreak => "Long break",
  };
}
