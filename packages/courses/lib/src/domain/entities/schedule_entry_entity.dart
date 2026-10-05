import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_entry_entity.freezed.dart';

@freezed
abstract class ScheduleEntryEntity with _$ScheduleEntryEntity {
  const factory ScheduleEntryEntity({
    required String id,
    String? serverId,
    @Default('') String idempotencyKey,
    @Default('synced') String syncStatus,
    String? lastSyncError,
    required String studentCourseId,
    required String dayOfWeek,
    required String startTime,
    required String endTime,
    String? venue,
    String? campus,
    String? section,
    String? label,
    String? color,
    @Default(true) bool isRecurring,
    DateTime? specificDate,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? courseTitle,
    String? courseCode,
    String? courseColor,
    DateTime? courseTermEndDate,
  }) = _ScheduleEntryEntity;
}
