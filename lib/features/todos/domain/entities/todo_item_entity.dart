import 'package:academia/features/todos/domain/entities/todo_tag_entity.dart';
import 'package:academia/features/todos/domain/enums/sync_status.dart';
import 'package:academia/features/todos/domain/enums/todo_priority.dart';
import 'package:academia/features/todos/domain/enums/todo_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'todo_item_entity.freezed.dart';

@freezed
abstract class TodoItemEntity with _$TodoItemEntity {
  const factory TodoItemEntity({
    required int localId,
    String? id,

    // Local FK to the parent TodoList
    required int taskListLocalId,

    required String title,
    String? notes,
    required TodoStatus status,
    required TodoPriority priority,

    DateTime? due,
    DateTime? completed,

    required int subtaskCount,
    String? position,
    required bool hidden,

    // Resolved tag entities — populated at query time via the junction table
    @Default([]) List<TodoTagEntity> tags,

    required SyncStatus syncStatus,
    DateTime? lastSyncedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    required bool isPendingDeletion,
    required bool isDirty,
  }) = _TodoItemEntity;
}
