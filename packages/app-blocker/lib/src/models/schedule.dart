import 'package:flutter/material.dart';

/// Represents a time-based schedule for blocking apps.
class BlockSchedule {
  /// Creates a [BlockSchedule] instance.
  ///
  /// For recurring schedules, provide [weekdays] and leave [scheduleDate] null.
  /// For one-time schedules, set [scheduleDate] (weekdays defaults to empty).
  ///
  /// Throws [ArgumentError] if:
  /// - Any weekday is outside the ISO 8601 range (1–7) for recurring schedules
  /// - Recurring schedule (scheduleDate is null) has no weekdays
  BlockSchedule({
    required this.id,
    required this.name,
    required this.appIdentifiers,
    this.weekdays = const [],
    required this.startTime,
    required this.endTime,
    this.enabled = true,
    this.scheduleDate,
  }) {
    if (scheduleDate == null) {
      if (weekdays.isEmpty) {
        throw ArgumentError.value(
          weekdays,
          'weekdays',
          'Recurring schedules must have at least one weekday. For one-time schedules, set scheduleDate instead.',
        );
      }
      for (final day in weekdays) {
        if (day < 1 || day > 7) {
          throw ArgumentError.value(
            day,
            'weekdays',
            'Weekday must be an ISO 8601 value between 1 (Monday) and 7 (Sunday).',
          );
        }
      }
    }
  }

  /// Unique identifier for this schedule.
  final String id;

  /// Human-readable name for the schedule.
  final String name;

  /// List of app identifiers to block during this schedule.
  ///
  /// On Android, these are package names. On iOS, these are opaque tokens
  /// obtained from [FamilyActivityPicker].
  final List<String> appIdentifiers;

  /// Days of the week when this schedule is active (for recurring schedules).
  ///
  /// Uses ISO 8601 numbering: 1 = Monday, 7 = Sunday.
  /// All values must be in the range 1–7.
  ///
  /// Defaults to empty. For recurring schedules (scheduleDate is null),
  /// at least one weekday must be provided.
  /// For one-time schedules (scheduleDate is set), this is ignored.
  final List<int> weekdays;

  /// The time of day when blocking starts.
  final TimeOfDay startTime;

  /// The time of day when blocking ends.
  final TimeOfDay endTime;

  /// Whether this schedule is currently enabled.
  final bool enabled;

  /// Specific date for one-time schedules.
  ///
  /// When null, this is a recurring schedule that repeats on [weekdays].
  /// When set, this is a one-time schedule that runs only on this date,
  /// and [weekdays] is ignored.
  ///
  /// One-time schedules automatically disable after their end time.
  ///
  /// Only the date portion is used; time-of-day is determined by [startTime]/[endTime].
  final DateTime? scheduleDate;

  /// Creates a copy with the given fields replaced.
  BlockSchedule copyWith({
    String? id,
    String? name,
    List<String>? appIdentifiers,
    List<int>? weekdays,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    bool? enabled,
    DateTime? scheduleDate,
  }) {
    return BlockSchedule(
      id: id ?? this.id,
      name: name ?? this.name,
      appIdentifiers: appIdentifiers ?? this.appIdentifiers,
      weekdays: weekdays ?? this.weekdays,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      enabled: enabled ?? this.enabled,
      scheduleDate: scheduleDate ?? this.scheduleDate,
    );
  }

  /// Creates a [BlockSchedule] from a platform channel map.
  factory BlockSchedule.fromMap(Map<String, dynamic> map) {
    final scheduleDateMillis = map['scheduleDate'] as int?;
    return BlockSchedule(
      id: map['id'] as String,
      name: map['name'] as String,
      appIdentifiers: List<String>.from(map['appIdentifiers'] as List),
      weekdays: List<int>.from(map['weekdays'] as List),
      startTime: TimeOfDay(
        hour: map['startHour'] as int,
        minute: map['startMinute'] as int,
      ),
      endTime: TimeOfDay(
        hour: map['endHour'] as int,
        minute: map['endMinute'] as int,
      ),
      enabled: map['enabled'] as bool? ?? true,
      scheduleDate: scheduleDateMillis != null
          ? DateTime.fromMillisecondsSinceEpoch(scheduleDateMillis)
          : null,
    );
  }

  /// Converts this instance to a platform channel map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'appIdentifiers': appIdentifiers,
      'weekdays': weekdays,
      'startHour': startTime.hour,
      'startMinute': startTime.minute,
      'endHour': endTime.hour,
      'endMinute': endTime.minute,
      'enabled': enabled,
      if (scheduleDate != null)
        'scheduleDate': scheduleDate!.millisecondsSinceEpoch,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlockSchedule &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    final dateStr = scheduleDate != null
        ? ', date: ${scheduleDate!.toIso8601String()}'
        : '';
    return 'BlockSchedule(id: $id, name: $name, enabled: $enabled$dateStr)';
  }
}
