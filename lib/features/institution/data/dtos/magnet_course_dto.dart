import 'package:academia/features/course/course.dart';
import 'package:academia/features/institution/data/mappers/course_with_schedules.dart';
import 'package:academia/features/timetable/timetable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  TimetableEntryEntity toEntity({
    required String courseId,
    required String fallbackUserId,
    String? fallbackTimetableId,
    String? fallbackInstitutionId,
  }) {
    const uuid = Uuid();
    return TimetableEntryEntity(
      id: id?.toString() ?? uuid.v4(),
      serverId: serverId != null ? int.tryParse(serverId.toString()) : null,
      userId: userId?.toString() ?? fallbackUserId,
      institutionId:
          int.tryParse(
            institutionId?.toString() ?? fallbackInstitutionId ?? '0',
          ) ??
          0,
      courseId: courseId,
      timetableId: timetableId?.toString() ?? fallbackTimetableId ?? uuid.v4(),
      rrule: rrule?.toString(),
      startDate: startDate != null
          ? DateTime.parse(startDate!)
          : DateTime.now(),
      durationMinutes: int.tryParse(durationMinutes?.toString() ?? '0') ?? 0,
      location: location?.toString(),
      room: room?.toString(),
      building: building?.toString(),
      isSynced: isSynced ?? false,
      isDeleted: isDeleted ?? false,
      lastUpdated: lastUpdated != null
          ? DateTime.parse(lastUpdated!)
          : DateTime.now(),
    );
  }
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
    @JsonKey(name: 'semester_id') dynamic semesterId,
    @JsonKey(name: 'course_schedules')
    @Default([])
    List<MagnetCourseScheduleDto> courseSchedules,
  }) = _MagnetCourseDto;

  factory MagnetCourseDto.fromJson(Map<String, dynamic> json) =>
      _$MagnetCourseDtoFromJson(json);
}

extension MagnetCourseDtoMapper on MagnetCourseDto {
  CourseWithSchedules toCourseWithSchedules({
    required String userId,
    String? timetableId,
  }) {
    const uuid = Uuid();
    final courseId = id?.toString() ?? uuid.v4();

    final course = CourseEntity(
      id: courseId,
      courseCode: courseCode ?? '',
      courseName: courseName ?? courseCode ?? '',
      instructor: instructor ?? '',
      isSynced: isSynced ?? false,
      color: Color(
        int.tryParse(
              color?.toString().replaceAll('0x', '').replaceAll('0X', '') ?? '',
              radix: 16,
            ) ??
            0xFFCBA6F7,
      ),
      isDeleted: isDeleted ?? false,
      createdAt: createdAt != null
          ? DateTime.parse(createdAt!)
          : DateTime.now(),
      updatedAt: updatedAt != null
          ? DateTime.parse(updatedAt!)
          : DateTime.now(),
      institutionId: int.tryParse(institutionId?.toString() ?? '0'),
      serverId: serverId != null ? int.tryParse(serverId.toString()) : null,
      semesterId: semesterId != null
          ? int.tryParse(semesterId.toString())
          : null,
    );

    final schedules = courseSchedules
        .map(
          (schedule) => schedule.toEntity(
            courseId: courseId,
            fallbackUserId: userId,
            fallbackTimetableId: timetableId,
            fallbackInstitutionId: institutionId?.toString(),
          ),
        )
        .toList();

    return CourseWithSchedules(course: course, schedules: schedules);
  }
}

/// Parses the raw `courses` array (with nested `course_schedules`) from a
/// Magnet scrape result.
List<CourseWithSchedules> parseCoursesWithSchedules(
  Map<String, dynamic> data, {
  required String userId,
  String? timetableId,
}) {
  final List<dynamic> rawList = data['courses'] ?? [];
  return rawList
      .map((json) => MagnetCourseDto.fromJson(Map<String, dynamic>.from(json)))
      .map(
        (dto) =>
            dto.toCourseWithSchedules(userId: userId, timetableId: timetableId),
      )
      .toList();
}

/// Offloads [parseCoursesWithSchedules] onto a background isolate via
/// [compute], matching the isolate-offload the original hand-parser used.
Future<List<CourseWithSchedules>> parseCoursesInBackground(
  Map<String, dynamic> data,
  String userId, {
  String? timetableId,
}) {
  return compute(
    (Map<String, dynamic> params) => parseCoursesWithSchedules(
      params['data'],
      userId: params['userId'],
      timetableId: params['timetableId'],
    ),
    {'data': data, 'userId': userId, 'timetableId': timetableId},
  );
}
