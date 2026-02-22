import 'package:freezed_annotation/freezed_annotation.dart';

part 'timetable_entry_entity.freezed.dart';

@freezed
abstract class TimetableEntryEntity with _$TimetableEntryEntity {
  const factory TimetableEntryEntity({
    /// Local UUID for offline-first identification
    String? id,

    /// Unique ID from the remote database
    int? serverId,

    required String userId,

    required int institutionId,

    /// References Course.id (UUID)
    required String courseId,

    /// References Timetable.id (UUID)
    required String timetableId,

    /// Recurrence Rule (e.g., "FREQ=WEEKLY;BYDAY=MO")
    String? rrule,

    /// Anchor date for the start of the event/series
    required DateTime startDate,

    /// Length of the session in minutes
    required int durationMinutes,

    String? location,

    String? room,

    String? building,

    @Default(false) bool isSynced,

    @Default(false) bool isDeleted,

    DateTime? lastUpdated,
  }) = _TimetableEntryEntity;
}
