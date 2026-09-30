// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_entry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScheduleEntryDto _$ScheduleEntryDtoFromJson(Map<String, dynamic> json) =>
    _ScheduleEntryDto(
      id: json['id'] as String? ?? '',
      dayOfWeek: json['day_of_week'] as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      venue: json['venue'] as String?,
      campus: json['campus'] as String?,
      section: json['section'] as String?,
      label: json['label'] as String?,
      color: json['color'] as String?,
      isRecurring: json['is_recurring'] as bool? ?? true,
      specificDate: json['specific_date'] == null
          ? null
          : DateTime.parse(json['specific_date'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      course: json['course'] == null
          ? null
          : ScheduleCourseDto.fromJson(json['course'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScheduleEntryDtoToJson(_ScheduleEntryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day_of_week': instance.dayOfWeek,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'venue': instance.venue,
      'campus': instance.campus,
      'section': instance.section,
      'label': instance.label,
      'color': instance.color,
      'is_recurring': instance.isRecurring,
      'specific_date': instance.specificDate?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'course': instance.course,
    };

_ScheduleCourseDto _$ScheduleCourseDtoFromJson(Map<String, dynamic> json) =>
    _ScheduleCourseDto(
      id: json['id'] as String,
      title: json['title'] as String,
      code: json['code'] as String?,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$ScheduleCourseDtoToJson(_ScheduleCourseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'code': instance.code,
      'color': instance.color,
    };
