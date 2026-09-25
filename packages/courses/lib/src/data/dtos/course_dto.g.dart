// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CourseDto _$CourseDtoFromJson(Map<String, dynamic> json) => _CourseDto(
  id: json['id'] as String,
  institution: (json['institution'] as num).toInt(),
  title: json['title'] as String,
  code: json['code'] as String?,
  termLabel: json['term_label'] as String?,
  academicYear: json['academic_year'] as String?,
  termStartDate: json['term_start_date'] == null
      ? null
      : DateTime.parse(json['term_start_date'] as String),
  termEndDate: json['term_end_date'] == null
      ? null
      : DateTime.parse(json['term_end_date'] as String),
  previousCourse: json['previous_course'] as String?,
  archivedAt: json['archived_at'] == null
      ? null
      : DateTime.parse(json['archived_at'] as String),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  lecturers:
      (json['lecturers'] as List<dynamic>?)
          ?.map((e) => LecturerDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$CourseDtoToJson(_CourseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'institution': instance.institution,
      'title': instance.title,
      'code': instance.code,
      'term_label': instance.termLabel,
      'academic_year': instance.academicYear,
      'term_start_date': instance.termStartDate?.toIso8601String(),
      'term_end_date': instance.termEndDate?.toIso8601String(),
      'previous_course': instance.previousCourse,
      'archived_at': instance.archivedAt?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'lecturers': instance.lecturers,
    };
