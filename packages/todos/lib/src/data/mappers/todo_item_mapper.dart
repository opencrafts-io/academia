import 'package:todos/src/domain/domain.dart';
import 'package:todos/src/data/dtos/todo_item_dto.dart';

extension TodoItemEntityMapper on TodoItemEntity {
  TodoItemEntity toDomain({List<TodoTagEntity> tags = const []}) =>
      copyWith(tags: tags);

  TodoItemEntity toDataModel({bool isDirty = true}) =>
      copyWith(isDirty: isDirty);

  TodoItemDto toDto() => TodoItemDto(
    id: id,
    taskList: null, // resolved from taskListLocalId at repository level
    title: title,
    notes: notes,
    status: status.name,
    statusDisplay: null,
    priority: priority.name,
    priorityDisplay: null,
    due: due?.toIso8601String(),
    completed: completed?.toIso8601String(),
    subtaskCount: subtaskCount,
    position: position,
    hidden: hidden,
    tags: tags.map((tag) => tag.id ?? '').where((id) => id.isNotEmpty).toList(),
    syncStatus: syncStatus.name,
    syncStatusDisplay: null,
    lastSyncedAt: lastSyncedAt?.toIso8601String(),
    createdAt: createdAt?.toIso8601String(),
    updatedAt: updatedAt?.toIso8601String(),
  );
}

extension TodoItemDtoMapper on TodoItemDto {
  /// [taskListLocalId] is resolved from the local task list table.
  ///
  /// Focus time remains local-only, so callers pass the current accumulated
  /// value when updating an existing item from the remote API.
  TodoItemEntity toEntity({
    int localId = 0,
    required int taskListLocalId,
    List<TodoTagEntity> tags = const [],
    int focusedSeconds = 0,
  }) => TodoItemEntity(
    localId: localId,
    id: id,
    taskListLocalId: taskListLocalId,
    title: title,
    notes: notes,
    status: _parseStatus(status),
    priority: _parsePriority(priority),
    due: _parseLocalDue(due),
    completed: completed != null ? DateTime.tryParse(completed!) : null,
    subtaskCount: subtaskCount,
    position: position,
    hidden: hidden,
    tags: tags,
    syncStatus: _parseSyncStatus(syncStatus),
    lastSyncedAt: lastSyncedAt != null
        ? DateTime.tryParse(lastSyncedAt!)
        : null,
    createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
    updatedAt: updatedAt != null ? DateTime.tryParse(updatedAt!) : null,
    isPendingDeletion: false,
    isDirty: false,
    focusedSeconds: focusedSeconds,
  );

  TodoItemEntity toDataModel({
    int localId = 0,
    required int taskListLocalId,
    bool isDirty = false,
    bool isPendingDeletion = false,
    int focusedSeconds = 0,
  }) => toEntity(
    localId: localId,
    taskListLocalId: taskListLocalId,
    focusedSeconds: focusedSeconds,
  ).copyWith(isDirty: isDirty, isPendingDeletion: isPendingDeletion);

  TodoStatus _parseStatus(String? value) => TodoStatus.values.firstWhere(
    (status) => status.name == value?.toLowerCase(),
    orElse: () => TodoStatus.needsAction,
  );

  TodoPriority _parsePriority(String? value) => TodoPriority.values.firstWhere(
    (priority) => priority.name == value?.toLowerCase(),
    orElse: () => TodoPriority.none,
  );

  SyncStatus _parseSyncStatus(String? value) => SyncStatus.values.firstWhere(
    (status) => status.name == value?.toLowerCase(),
    orElse: () => SyncStatus.pending,
  );

  /// Due values represent a local wall-clock time; audit timestamps are UTC.
  DateTime? _parseLocalDue(String? value) =>
      value == null ? null : DateTime.tryParse(value)?.toLocal();
}
