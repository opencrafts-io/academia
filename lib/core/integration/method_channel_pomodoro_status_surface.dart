import 'package:flutter/services.dart';
import 'package:pomodoro/pomodoro.dart';

class MethodChannelPomodoroStatusSurface implements PomodoroStatusSurface {
  MethodChannelPomodoroStatusSurface({MethodChannel? channel})
    : _channel = channel ?? const MethodChannel(_channelName);

  static const String _channelName = 'io.opencrafts.academia/pomodoro_status';

  final MethodChannel _channel;

  @override
  Future<void> start(PomodoroStatus status) => _invoke('start', status);

  @override
  Future<void> update(PomodoroStatus status) => _invoke('update', status);

  @override
  Future<void> stop(String sessionId) async {
    try {
      await _channel.invokeMethod<void>('stop', {'sessionId': sessionId});
    } on MissingPluginException {
      // Platforms without a native status surface continue with the in-app UI.
    } on PlatformException {
      // Notification or Live Activity availability is controlled by the OS.
    }
  }

  Future<void> _invoke(String method, PomodoroStatus status) async {
    try {
      await _channel.invokeMethod<void>(method, {
        'sessionId': status.sessionId,
        'phase': status.phase.name,
        'startAtEpochMillis': status.startAtEpochMillis,
        'endAtEpochMillis': status.endsAtEpochMillis,
        'remainingSeconds': status.remainingSeconds,
        'totalDurationSeconds': status.totalDurationSeconds,
        'isRunning': status.isRunning,
        'todoTitle': status.todoTitle,
      });
    } on MissingPluginException {
      // Platforms without a native status surface continue with the in-app UI.
    } on PlatformException {
      // Notification or Live Activity availability is controlled by the OS.
    }
  }
}
