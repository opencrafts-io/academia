import 'package:freezed_annotation/freezed_annotation.dart';

import 'lecturer_entity.dart';

part 'course_entity.freezed.dart';

@freezed
abstract class CourseEntity with _$CourseEntity {
  const factory CourseEntity({
    required String id,
    required int institutionId,
    required String title,
    String? code,
    String? termLabel,
    String? academicYear,
    DateTime? termStartDate,
    DateTime? termEndDate,
    String? previousCourseId,
    DateTime? archivedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<LecturerEntity> lecturers,
  }) = _CourseEntity;
}
