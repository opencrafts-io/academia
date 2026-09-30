import 'dart:async';
import 'dart:math' as math;

import 'package:courses/courses.dart' as courses;
import 'package:flutter/foundation.dart';
import 'package:notifications/notifications.dart';
import 'package:permissions/permissions.dart';

class CourseScheduleReminderService implements courses.CourseReminderRefresher {
  CourseScheduleReminderService({
    required this._repository,
    required this._scheduler,
    required this._permissions,
  });

  final courses.CourseRepository _repository;
  final LocalNotificationScheduler _scheduler;
  final PermissionGateway _permissions;
  final _planner = const courses.CourseReminderPlanner();

  bool _enabled = true;
  bool _refreshing = false;
  bool _refreshRequested = false;
  bool _receivedPreferences = false;
  List<int?> _reminderMinutes = [1440, 60, 0];

  @override
  void updatePreferences({
    required bool enabled,
    required List<int?> reminderMinutes,
  }) {
    final normalized = List<int?>.generate(
      3,
      (index) => index < reminderMinutes.length ? reminderMinutes[index] : null,
    );
    if (_receivedPreferences &&
        _enabled == enabled &&
        listEquals(_reminderMinutes, normalized)) {
      return;
    }
    _receivedPreferences = true;
    _enabled = enabled;
    _reminderMinutes = normalized;
    unawaited(refresh());
  }

  @override
  Future<void> refresh() async {
    if (_refreshing) {
      _refreshRequested = true;
      return;
    }
    _refreshing = true;
    try {
      do {
        _refreshRequested = false;
        await _refreshOnce();
      } while (_refreshRequested);
    } catch (error, stackTrace) {
      debugPrint('Could not refresh class reminders: $error\n$stackTrace');
    } finally {
      _refreshing = false;
    }
  }

  Future<void> _refreshOnce() async {
    if (kIsWeb ||
        (defaultTargetPlatform != TargetPlatform.android &&
            defaultTargetPlatform != TargetPlatform.iOS)) {
      return;
    }
    if (!_enabled) {
      await _scheduler.cancelScheduledForChannel(
        LocalNotificationChannel.courseAlerts,
      );
      return;
    }

    final result = await _repository.listCachedStudentSchedule();
    final entries = result.fold<List<courses.ScheduleEntryEntity>?>((failure) {
      debugPrint('Could not read class reminders: ${failure.message}');
      return null;
    }, (entries) => entries);
    if (entries == null) return;

    await _scheduler.cancelScheduledForChannel(
      LocalNotificationChannel.courseAlerts,
    );
    if (entries.isEmpty) return;

    final precise = await _hasPreciseAlarmAccess();
    final now = DateTime.now();
    final alarms = [
      for (final entry in entries)
        ..._planner
            .plan(entry, reminderMinutes: _reminderMinutes, now: now)
            .map((alarm) => (entry: entry, alarm: alarm)),
    ]..sort((a, b) => a.alarm.at.compareTo(b.alarm.at));

    final limit = defaultTargetPlatform == TargetPlatform.iOS ? 64 : 500;
    int pendingCount;
    try {
      pendingCount = await _scheduler.scheduledCount();
    } catch (_) {
      pendingCount = 0;
    }
    final available = math.max(0, limit - pendingCount).toInt();

    for (final scheduled in alarms.take(available)) {
      final entry = scheduled.entry;
      final alarm = scheduled.alarm;
      try {
        await _scheduler.schedule(
          LocalNotificationRequest(
            id: alarm.id,
            channel: LocalNotificationChannel.courseAlerts,
            title: entry.label?.trim().isNotEmpty == true
                ? entry.label!.trim()
                : entry.courseTitle ?? 'Class reminder',
            body: _body(entry, alarm.minutesBefore),
            summary: _leadTime(alarm.minutesBefore),
            category: LocalNotificationCategory.reminder,
            payload: {
              'type': 'course_reminder',
              'schedule_entry_id': entry.id,
              'course_id': entry.studentCourseId,
            },
            schedule: LocalNotificationSchedule.at(
              alarm.at,
              precise: precise,
              weekday: alarm.weekday,
            ),
          ),
        );
      } catch (error) {
        debugPrint('Could not schedule a class reminder: $error');
      }
    }
    if (alarms.length > available) {
      debugPrint(
        'Some class reminders were not queued because the platform '
        'notification limit was reached.',
      );
    }
  }

  Future<bool> _hasPreciseAlarmAccess() async {
    if (defaultTargetPlatform != TargetPlatform.android) return false;
    try {
      return await _permissions.check(PermissionCapability.preciseAlarms) ==
          PermissionStatus.granted;
    } catch (_) {
      return false;
    }
  }

  String _body(courses.ScheduleEntryEntity entry, int minutesBefore) {
    final time = entry.startTime.length >= 5
        ? entry.startTime.substring(0, 5)
        : entry.startTime;
    final details = [
      if (entry.courseCode?.isNotEmpty == true) entry.courseCode,
      if (entry.venue?.isNotEmpty == true) entry.venue,
      if (entry.campus?.isNotEmpty == true) entry.campus,
      if (entry.section?.isNotEmpty == true) 'Section ${entry.section}',
    ].whereType<String>().join(' · ');
    return [
      '${_leadTime(minutesBefore)} · $time',
      if (details.isNotEmpty) details,
    ].join('\n');
  }

  String _leadTime(int minutes) {
    if (minutes == 0) return 'Class is starting now';
    if (minutes % 1440 == 0) {
      final days = minutes ~/ 1440;
      return 'Class starts in $days ${days == 1 ? 'day' : 'days'}';
    }
    if (minutes % 60 == 0) {
      final hours = minutes ~/ 60;
      return 'Class starts in $hours ${hours == 1 ? 'hour' : 'hours'}';
    }
    return 'Class starts in $minutes minutes';
  }
}
