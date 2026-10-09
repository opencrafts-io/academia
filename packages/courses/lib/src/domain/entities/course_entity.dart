import 'package:freezed_annotation/freezed_annotation.dart';

import 'lecturer_entity.dart';
import 'schedule_entry_entity.dart';

part 'course_entity.freezed.dart';

@freezed
abstract class CourseEntity with _$CourseEntity {
  const factory CourseEntity({
    required String id,
    String? serverId,
    @Default('') String idempotencyKey,
    @Default('synced') String syncStatus,
    String? lastSyncError,
    required int institutionId,
    required String title,
    String? code,
    String? color,
    String? termLabel,
    String? academicYear,
    DateTime? termStartDate,
    DateTime? termEndDate,
    String? previousCourseId,
    DateTime? archivedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<LecturerEntity> lecturers,
    @Default([]) List<ScheduleEntryEntity> scheduleEntries,
  }) = _CourseEntity;
}
