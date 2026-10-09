import 'package:courses/courses.dart' as courses;
import 'package:academia/features/institution/data/mappers/magnet_course_import.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'magnet_course_dto.freezed.dart';
part 'magnet_course_dto.g.dart';

/// Mirrors a single entry of the nested `course_schedules` array under a
/// scraped course. Fields the original parser only ever trusted after a
/// defensive `.toString()` stay `dynamic` here rather than a strict String/int
/// type, since the scraped source is not guaranteed to send a consistent type
/// per field — matching the original hand-parser's tolerance exactly rather
/// than introducing a new cast-failure mode json_serializable would enforce.
@freezed
abstract class MagnetCourseScheduleDto with _$MagnetCourseScheduleDto {
  const factory MagnetCourseScheduleDto({
    dynamic id,
    @JsonKey(name: 'server_id') dynamic serverId,
    @JsonKey(name: 'user_id') dynamic userId,
    @JsonKey(name: 'institution_id') dynamic institutionId,
    @JsonKey(name: 'timetable_id') dynamic timetableId,
    dynamic rrule,
    @JsonKey(name: 'start_date') String? startDate,
    @JsonKey(name: 'duration_minutes') dynamic durationMinutes,
    dynamic location,
    dynamic room,
    dynamic building,
    @JsonKey(name: 'is_synced') bool? isSynced,
    @JsonKey(name: 'is_deleted') bool? isDeleted,
    @JsonKey(name: 'last_updated') String? lastUpdated,
  }) = _MagnetCourseScheduleDto;

  factory MagnetCourseScheduleDto.fromJson(Map<String, dynamic> json) =>
      _$MagnetCourseScheduleDtoFromJson(json);
}

extension MagnetCourseScheduleDtoMapper on MagnetCourseScheduleDto {
  List<courses.ScheduleEntryEntity> toScheduleEntries({
    required String courseId,
  }) {
    if (isDeleted == true) return const [];

    const uuid = Uuid();
    final start = DateTime.tryParse(startDate ?? '')?.toLocal();
    if (start == null) return const [];

    final duration = int.tryParse(durationMinutes?.toString() ?? '') ?? 0;
    if (duration <= 0) return const [];
    final end = start.add(Duration(minutes: duration));
    final recurring = (rrule?.toString().trim().isNotEmpty ?? false);
    final weekdays = _weekdaysFromRule(rrule?.toString(), start.weekday);
    final now = DateTime.now();
    final place = [location, room, building]
        .map((value) => value?.toString().trim() ?? '')
        .where((value) => value.isNotEmpty)
        .toSet()
        .join(' · ');

    return weekdays.map((weekday) {
      final idSuffix = weekdays.length == 1 ? '' : '-$weekday';
      return courses.ScheduleEntryEntity(
        id: '${id?.toString() ?? uuid.v4()}$idSuffix',
        studentCourseId: courseId,
        dayOfWeek: _weekdayNames[weekday - 1],
        startTime: _formatTime(start),
        endTime: _formatTime(end),
        venue: place.isEmpty ? null : place,
        isRecurring: recurring,
        specificDate: recurring
            ? null
            : DateTime(start.year, start.month, start.day),
        createdAt: now,
        updatedAt: now,
      );
    }).toList();
  }

  static const _weekdayNames = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday',
  ];

  static List<int> _weekdaysFromRule(String? rule, int fallbackWeekday) {
    final byDay = RegExp(
      r'(?:^|;)BYDAY=([^;]+)',
      caseSensitive: false,
    ).firstMatch(rule ?? '')?.group(1);
    if (byDay == null || byDay.trim().isEmpty) return [fallbackWeekday];

    const codes = {
      'MO': DateTime.monday,
      'TU': DateTime.tuesday,
      'WE': DateTime.wednesday,
      'TH': DateTime.thursday,
      'FR': DateTime.friday,
      'SA': DateTime.saturday,
      'SU': DateTime.sunday,
    };
    final weekdays =
        byDay
            .split(',')
            .map((code) => codes[code.trim().toUpperCase()])
            .whereType<int>()
            .toSet()
            .toList()
          ..sort();
    return weekdays.isEmpty ? [fallbackWeekday] : weekdays;
  }

  static String _formatTime(DateTime value) =>
      '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
}

/// Mirrors a single entry of the raw `courses` array returned by a Magnet
/// scrape, including its nested `course_schedules`.
@freezed
abstract class MagnetCourseDto with _$MagnetCourseDto {
  const factory MagnetCourseDto({
    dynamic id,
    @JsonKey(name: 'course_code') String? courseCode,
    @JsonKey(name: 'course_name') String? courseName,
    String? instructor,
    @JsonKey(name: 'is_synced') bool? isSynced,
    dynamic color,
    @JsonKey(name: 'is_deleted') bool? isDeleted,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'institution_id') dynamic institutionId,
    @JsonKey(name: 'server_id') dynamic serverId,
    @JsonKey(name: 'course_schedules')
    @Default([])
    List<MagnetCourseScheduleDto> courseSchedules,
  }) = _MagnetCourseDto;

  factory MagnetCourseDto.fromJson(Map<String, dynamic> json) =>
      _$MagnetCourseDtoFromJson(json);
}

extension MagnetCourseDtoMapper on MagnetCourseDto {
  MagnetCourseImport toCourseImport({required int institutionId}) {
    const uuid = Uuid();
    final courseId = id?.toString() ?? uuid.v4();
    final rawColor = color?.toString().trim();
    final hexColor = rawColor
        ?.replaceFirst(RegExp(r'^#'), '')
        .replaceFirst(RegExp(r'^0x', caseSensitive: false), '');
    final parsedColor = color is int
        ? color as int
        : hexColor == null
        ? null
        : int.tryParse(hexColor, radix: 16);
    final course = courses.CreateCourseParams(
      institutionId: institutionId,
      title: courseName ?? courseCode ?? 'Untitled course',
      code: courseCode,
      color: parsedColor == null ? null : '#${parsedColor.toRadixString(16)}',
    );

    final schedules = courseSchedules
        .expand((schedule) => schedule.toScheduleEntries(courseId: courseId))
        .toList();
    return MagnetCourseImport(course: course, schedules: schedules);
  }
}

/// Parses the raw `courses` array (with nested `course_schedules`) from a
/// Magnet scrape result.
List<MagnetCourseImport> parseCoursesWithSchedules(
  Map<String, dynamic> data, {
  required int institutionId,
}) {
  final List<dynamic> rawList = data['courses'] ?? [];
  return rawList
      .map((json) => MagnetCourseDto.fromJson(Map<String, dynamic>.from(json)))
      .where((dto) => dto.isDeleted != true)
      .map((dto) => dto.toCourseImport(institutionId: institutionId))
      .toList();
}

/// Offloads [parseCoursesWithSchedules] onto a background isolate via
/// [compute], matching the isolate-offload the original hand-parser used.
Future<List<MagnetCourseImport>> parseCoursesInBackground(
  Map<String, dynamic> data,
  int institutionId,
) {
  return compute(
    (Map<String, dynamic> params) => parseCoursesWithSchedules(
      params['data'],
      institutionId: params['institutionId'],
    ),
    {'data': data, 'institutionId': institutionId},
  );
}
