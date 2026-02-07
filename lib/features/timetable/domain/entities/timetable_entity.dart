import 'package:freezed_annotation/freezed_annotation.dart';

part 'timetable_entity.freezed.dart';

@freezed
abstract class TimetableEntity with _$TimetableEntity {
  const factory TimetableEntity({
    /// Local unique identifier (UUID) for offline-first tracking
    String? id,

    /// Remote database identifier, null if not yet synced
    int? serverId,

    required String name,

    required String userId,

    int? institutionId,

    @Default(false) bool isSynced,

    @Default(false) bool isDeleted,

    DateTime? createdAt,

    DateTime? updatedAt,
  }) = _TimetableEntity;
}
