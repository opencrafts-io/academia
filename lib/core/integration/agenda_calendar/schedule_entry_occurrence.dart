import 'package:courses/courses.dart' as courses;
import 'package:flutter/material.dart';

bool scheduleEntryOccursOnDay(courses.ScheduleEntryEntity entry, DateTime day) {
  if (courses.courseTermHasEndedOn(entry.courseTermEndDate, day)) {
    return false;
  }

  final specificDate = entry.specificDate;
  if (specificDate != null) {
    return DateUtils.isSameDay(specificDate, day);
  }
  if (!entry.isRecurring) return false;

  const weekdays = {
    DateTime.monday: 'monday',
    DateTime.tuesday: 'tuesday',
    DateTime.wednesday: 'wednesday',
    DateTime.thursday: 'thursday',
    DateTime.friday: 'friday',
    DateTime.saturday: 'saturday',
    DateTime.sunday: 'sunday',
  };
  return entry.dayOfWeek.trim().toLowerCase() == weekdays[day.weekday];
}

DateTime? scheduleEntryTimeOnDay(String time, DateTime day) {
  final parts = time.split(':');
  if (parts.length < 2) return null;

  final hour = int.tryParse(parts[0]);
  final minute = int.tryParse(parts[1]);
  final second = parts.length > 2 ? int.tryParse(parts[2]) ?? 0 : 0;
  if (hour == null || minute == null || hour > 23 || minute > 59) {
    return null;
  }

  return DateTime(day.year, day.month, day.day, hour, minute, second);
}
