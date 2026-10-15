import 'dart:convert';

import 'package:pomodoro/pomodoro.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesPomodoroSessionStore implements PomodoroSessionStore {
  static const String _key = 'pomodoro.session.v1';

  @override
  Future<PomodoroSessionSnapshot?> read() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final encoded = preferences.getString(_key);
      if (encoded == null) return null;
      final json = jsonDecode(encoded) as Map<String, dynamic>;
      return PomodoroSessionSnapshot(
        phase: PomodoroPhase.values.byName(json['phase'] as String),
        remainingSeconds: json['remainingSeconds'] as int,
        isRunning: json['isRunning'] as bool,
        endsAtEpochMillis: json['endsAtEpochMillis'] as int?,
        completedFocusSessions: json['completedFocusSessions'] as int,
        focusDurationSeconds: json['focusDurationSeconds'] as int,
        shortBreakDurationSeconds: json['shortBreakDurationSeconds'] as int,
        longBreakDurationSeconds: json['longBreakDurationSeconds'] as int,
        sessionsBeforeLongBreak: json['sessionsBeforeLongBreak'] as int,
        sessionId: json['sessionId'] as String?,
        linkedTodoLocalId: json['linkedTodoLocalId'] as int?,
      );
    } on Object {
      return null;
    }
  }

  @override
  Future<void> write(PomodoroSessionSnapshot snapshot) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      await preferences.setString(
        _key,
        jsonEncode({
          'phase': snapshot.phase.name,
          'remainingSeconds': snapshot.remainingSeconds,
          'isRunning': snapshot.isRunning,
          'endsAtEpochMillis': snapshot.endsAtEpochMillis,
          'completedFocusSessions': snapshot.completedFocusSessions,
          'focusDurationSeconds': snapshot.focusDurationSeconds,
          'shortBreakDurationSeconds': snapshot.shortBreakDurationSeconds,
          'longBreakDurationSeconds': snapshot.longBreakDurationSeconds,
          'sessionsBeforeLongBreak': snapshot.sessionsBeforeLongBreak,
          'sessionId': snapshot.sessionId,
          'linkedTodoLocalId': snapshot.linkedTodoLocalId,
        }),
      );
    } on Object {
      // Persistence failure must not prevent an in-memory timer from running.
    }
  }
}
