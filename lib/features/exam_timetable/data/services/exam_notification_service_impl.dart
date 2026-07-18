import 'package:academia/core/core.dart';
import 'package:academia/features/exam_timetable/domain/domain.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:intl/intl.dart';

/// Room for growth per exam before slot indices would collide with the next
/// exam's bucket.
const int _kSlotsPerEntry = 10;

/// Exams don't have a sequential integer id the way todos' Drift-generated
/// localId does (identity is the institutionId/courseCode composite key), so
/// notification ids are derived from a bounded hash bucket instead. Keeps
/// `NotificationNamespaces.exams + (bucket * _kSlotsPerEntry) + slot.index`
/// well within int32 range with room for millions of distinct exams.
const int _kKeyBucketSize = 1000000;

enum _ExamReminderSlot { dayBefore, threeHoursBefore, thirtyMinBefore, start }

class ExamNotificationServiceImpl implements ExamNotificationService {
  int _idFor(String examKey, _ExamReminderSlot slot) {
    final bucket = examKey.hashCode.abs() % _kKeyBucketSize;
    return NotificationNamespaces.exams +
        (bucket * _kSlotsPerEntry) +
        slot.index;
  }

  String _keyFor({required int institutionId, required String courseCode}) =>
      '$institutionId:$courseCode';

  @override
  Future<void> scheduleReminder(ExamTimetable exam) async {
    final key = _keyFor(
      institutionId: exam.institutionId,
      courseCode: exam.courseCode,
    );
    final courseCode = exam.courseCode.replaceAll('\n', ' ');

    for (final slot in _ExamReminderSlot.values) {
      final scheduledAt = exam.datetimeStr.subtract(_offsetFor(slot));

      if (scheduledAt.isBefore(DateTime.now())) continue;

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: _idFor(key, slot),
          channelKey: 'exam_alerts_v2',
          title: _reminderTitle(slot, courseCode),
          summary: courseCode,
          body: '📍 ${exam.venue} • 🕐 ${_formatTime(exam.startTime)}',
          category: NotificationCategory.Reminder,
          largeIcon: 'asset://assets/icons/motarboard.png',
          roundedLargeIcon: true,
          wakeUpScreen: true,
          criticalAlert: true,
          displayOnForeground: true,
          displayOnBackground: true,
          payload: {
            'institutionId': exam.institutionId.toString(),
            'courseCode': exam.courseCode,
          },
          notificationLayout: NotificationLayout.BigText,
        ),
        schedule: NotificationCalendar.fromDate(
          date: scheduledAt,
          preciseAlarm: true,
          allowWhileIdle: true,
          repeats: false,
        ),
      );
    }
  }

  @override
  Future<void> cancelReminder({
    required int institutionId,
    required String courseCode,
  }) async {
    final key = _keyFor(institutionId: institutionId, courseCode: courseCode);
    for (final slot in _ExamReminderSlot.values) {
      await AwesomeNotifications().cancel(_idFor(key, slot));
    }
  }

  Duration _offsetFor(_ExamReminderSlot slot) {
    return switch (slot) {
      _ExamReminderSlot.dayBefore => const Duration(hours: 24),
      _ExamReminderSlot.threeHoursBefore => const Duration(hours: 3),
      _ExamReminderSlot.thirtyMinBefore => const Duration(minutes: 30),
      _ExamReminderSlot.start => Duration.zero,
    };
  }

  String _reminderTitle(_ExamReminderSlot slot, String courseCode) {
    return switch (slot) {
      _ExamReminderSlot.dayBefore => '📚 $courseCode exam tomorrow',
      _ExamReminderSlot.threeHoursBefore => '⏰ $courseCode exam in 3 hours',
      _ExamReminderSlot.thirtyMinBefore => '🔥 $courseCode exam in 30 minutes',
      _ExamReminderSlot.start => '🚨 $courseCode exam is starting now',
    };
  }

  String _formatTime(String isoTime) {
    try {
      final dt = DateTime.parse(isoTime).toLocal();
      return DateFormat('h:mm a').format(dt);
    } catch (_) {
      return isoTime;
    }
  }
}
