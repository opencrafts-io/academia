// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magnet_course_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MagnetCourseScheduleDto _$MagnetCourseScheduleDtoFromJson(
  Map<String, dynamic> json,
) => _MagnetCourseScheduleDto(
  id: json['id'],
  serverId: json['server_id'],
  userId: json['user_id'],
  institutionId: json['institution_id'],
  timetableId: json['timetable_id'],
  rrule: json['rrule'],
  startDate: json['start_date'] as String?,
  durationMinutes: json['duration_minutes'],
  location: json['location'],
  room: json['room'],
  building: json['building'],
  isSynced: json['is_synced'] as bool?,
  isDeleted: json['is_deleted'] as bool?,
  lastUpdated: json['last_updated'] as String?,
);

Map<String, dynamic> _$MagnetCourseScheduleDtoToJson(
  _MagnetCourseScheduleDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'server_id': instance.serverId,
  'user_id': instance.userId,
  'institution_id': instance.institutionId,
  'timetable_id': instance.timetableId,
  'rrule': instance.rrule,
  'start_date': instance.startDate,
  'duration_minutes': instance.durationMinutes,
  'location': instance.location,
  'room': instance.room,
  'building': instance.building,
  'is_synced': instance.isSynced,
  'is_deleted': instance.isDeleted,
  'last_updated': instance.lastUpdated,
};

_MagnetCourseDto _$MagnetCourseDtoFromJson(Map<String, dynamic> json) =>
    _MagnetCourseDto(
      id: json['id'],
      courseCode: json['course_code'] as String?,
      courseName: json['course_name'] as String?,
      instructor: json['instructor'] as String?,
      isSynced: json['is_synced'] as bool?,
      color: json['color'],
      isDeleted: json['is_deleted'] as bool?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      institutionId: json['institution_id'],
      serverId: json['server_id'],
      semesterId: json['semester_id'],
      courseSchedules:
          (json['course_schedules'] as List<dynamic>?)
              ?.map(
                (e) =>
                    MagnetCourseScheduleDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MagnetCourseDtoToJson(_MagnetCourseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course_code': instance.courseCode,
      'course_name': instance.courseName,
      'instructor': instance.instructor,
      'is_synced': instance.isSynced,
      'color': instance.color,
      'is_deleted': instance.isDeleted,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'institution_id': instance.institutionId,
      'server_id': instance.serverId,
      'semester_id': instance.semesterId,
      'course_schedules': instance.courseSchedules,
    };
