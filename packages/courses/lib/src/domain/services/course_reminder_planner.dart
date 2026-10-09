import '../entities/schedule_entry_entity.dart';

class CourseReminderAlarm {
  const CourseReminderAlarm({
    required this.id,
    required this.minutesBefore,
    required this.at,
    this.weekday,
  });

  final int id;
  final int minutesBefore;
  final DateTime at;
  final int? weekday;
}

class CourseReminderPlanner {
  const CourseReminderPlanner();

  List<CourseReminderAlarm> plan(
    ScheduleEntryEntity entry, {
    required List<int?> reminderMinutes,
    required DateTime now,
  }) {
    final start = _parseTime(entry.startTime);
    if (start == null) return const [];

    final alarms = <CourseReminderAlarm>[];
    for (var index = 0; index < reminderMinutes.length; index++) {
      final minutesBefore = reminderMinutes[index];
      if (minutesBefore == null || minutesBefore < 0) continue;

      final at = entry.isRecurring
          ? _nextWeeklyReminder(entry.dayOfWeek, start, minutesBefore, now)
          : _specificDateReminder(entry.specificDate, start, minutesBefore);
      if (at == null || !at.isAfter(now)) continue;

      alarms.add(
        CourseReminderAlarm(
          id: _notificationId(entry.id, index),
          minutesBefore: minutesBefore,
          at: at,
          weekday: entry.isRecurring ? at.weekday : null,
        ),
      );
    }
    alarms.sort((a, b) => a.at.compareTo(b.at));
    return alarms;
  }

  DateTime? _nextWeeklyReminder(
    String dayOfWeek,
    _ClassTime start,
    int minutesBefore,
    DateTime now,
  ) {
    final weekday = _weekdays[dayOfWeek.toLowerCase()];
    if (weekday == null) return null;

    final daysUntilClass =
        (weekday - now.weekday + DateTime.daysPerWeek) % DateTime.daysPerWeek;
    var classStart = DateTime(
      now.year,
      now.month,
      now.day + daysUntilClass,
      start.hour,
      start.minute,
    );
    var reminder = classStart.subtract(Duration(minutes: minutesBefore));
    while (!reminder.isAfter(now)) {
      classStart = classStart.add(const Duration(days: DateTime.daysPerWeek));
      reminder = classStart.subtract(Duration(minutes: minutesBefore));
    }
    return reminder;
  }

  DateTime? _specificDateReminder(
    DateTime? specificDate,
    _ClassTime start,
    int minutesBefore,
  ) {
    if (specificDate == null) return null;
    return DateTime(
      specificDate.year,
      specificDate.month,
      specificDate.day,
      start.hour,
      start.minute,
    ).subtract(Duration(minutes: minutesBefore));
  }

  _ClassTime? _parseTime(String value) {
    final parts = value.split(':');
    if (parts.length < 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null ||
        minute == null ||
        hour < 0 ||
        hour > 23 ||
        minute < 0 ||
        minute > 59) {
      return null;
    }
    return _ClassTime(hour, minute);
  }

  int _notificationId(String entryId, int reminderIndex) {
    var hash = 0x811c9dc5;
    for (final unit in 'course-reminder:$entryId:$reminderIndex'.codeUnits) {
      hash = ((hash ^ unit) * 0x01000193) & 0xffffffff;
    }
    final id = hash & 0x7fffffff;
    return id == 0 ? 1 : id;
  }

  static const _weekdays = {
    'monday': DateTime.monday,
    'tuesday': DateTime.tuesday,
    'wednesday': DateTime.wednesday,
    'thursday': DateTime.thursday,
    'friday': DateTime.friday,
    'saturday': DateTime.saturday,
    'sunday': DateTime.sunday,
  };
}

class _ClassTime {
  const _ClassTime(this.hour, this.minute);

  final int hour;
  final int minute;
}
