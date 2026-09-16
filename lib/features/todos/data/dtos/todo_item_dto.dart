import 'package:freezed_annotation/freezed_annotation.dart';
part 'todo_item_dto.freezed.dart';
part 'todo_item_dto.g.dart';

@freezed
abstract class TodoItemDto with _$TodoItemDto {
  const factory TodoItemDto({
    required String? id,
    @JsonKey(name: 'task_list') required String? taskList,
    required String title,
    required String? notes,
    required String? status,
    @JsonKey(name: 'status_display') required String? statusDisplay,
    required String? priority,
    @JsonKey(name: 'priority_display') required String? priorityDisplay,
    required String? due,
    required String? completed,
    @JsonKey(name: 'subtask_count') required int subtaskCount,
    required String? position,
    required bool hidden,
    // List of tag UUIDs — resolve to local IDs at mapping time
    required List<String> tags,
    @JsonKey(name: 'sync_status') required String? syncStatus,
    @JsonKey(name: 'sync_status_display') required String? syncStatusDisplay,
    @JsonKey(name: 'last_synced_at') required String? lastSyncedAt,
    @JsonKey(name: 'created_at') required String? createdAt,
    @JsonKey(name: 'updated_at') required String? updatedAt,
  }) = _TodoItemDto;

  factory TodoItemDto.fromJson(Map<String, dynamic> json) =>
      _$TodoItemDtoFromJson(json);
}
