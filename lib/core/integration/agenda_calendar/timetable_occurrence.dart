import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';

bool timetableEntryOccursOnDay(TimetableEntryEntity entry, DateTime day) {
  final rule = entry.rrule?.trim() ?? '';
  if (rule.isEmpty) return DateUtils.isSameDay(entry.startDate, day);

  const weekdayCodes = {
    DateTime.monday: 'MO',
    DateTime.tuesday: 'TU',
    DateTime.wednesday: 'WE',
    DateTime.thursday: 'TH',
    DateTime.friday: 'FR',
    DateTime.saturday: 'SA',
    DateTime.sunday: 'SU',
  };

  final dayCode = weekdayCodes[day.weekday]!;
  final byDay = RegExp(r'BYDAY=([^;]+)').firstMatch(rule)?.group(1);
  if (byDay == null) {
    return rule.contains('FREQ=DAILY') &&
        (day.isAfter(entry.startDate) ||
            DateUtils.isSameDay(entry.startDate, day));
  }

  return byDay.split(',').map((value) => value.trim()).contains(dayCode);
}
