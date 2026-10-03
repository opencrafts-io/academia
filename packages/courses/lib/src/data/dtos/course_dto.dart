import 'package:freezed_annotation/freezed_annotation.dart';

import 'lecturer_dto.dart';
import 'schedule_entry_dto.dart';

part 'course_dto.freezed.dart';
part 'course_dto.g.dart';

@freezed
abstract class CourseDto with _$CourseDto {
  const factory CourseDto({
    required String id,
    required int institution,
    required String title,
    String? code,
    String? color,
    @JsonKey(name: 'term_label') String? termLabel,
    @JsonKey(name: 'academic_year') String? academicYear,
    @JsonKey(name: 'term_start_date') DateTime? termStartDate,
    @JsonKey(name: 'term_end_date') DateTime? termEndDate,
    @JsonKey(name: 'previous_course') String? previousCourse,
    @JsonKey(name: 'archived_at') DateTime? archivedAt,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @Default([]) List<LecturerDto> lecturers,
    @JsonKey(name: 'schedule_entries')
    @Default([])
    List<ScheduleEntryDto> scheduleEntries,
  }) = _CourseDto;

  factory CourseDto.fromJson(Map<String, dynamic> json) =>
      _$CourseDtoFromJson(json);
}
