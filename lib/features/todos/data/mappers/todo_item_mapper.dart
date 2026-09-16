import 'package:academia/database/database.dart';
import 'package:academia/features/todos/data/dtos/todo_item_dto.dart';
import 'package:academia/features/todos/domain/domain.dart';

extension TodoItemDataMapper on TodoItem {
  /// Tags must be resolved separately via the junction table
  /// and passed in — Drift doesn't auto-join them.
  TodoItemEntity toDomain({List<TodoTagEntity> tags = const []}) =>
      TodoItemEntity(
        localId: localId,
        id: id,
        taskListLocalId: taskListLocalId,
        title: title,
        notes: notes,
        status: status,
        priority: priority,
        due: due,
        completed: completed,
        subtaskCount: subtaskCount,
        position: position,
        hidden: hidden,
        tags: tags,
        syncStatus: syncStatus,
        lastSyncedAt: lastSyncedAt,
        createdAt: createdAt,
        updatedAt: updatedAt,
        isPendingDeletion: isPendingDeletion,
        isDirty: isDirty,
      );

  TodoItemDto toDto() => TodoItemDto(
    id: id,
    taskList: null, // resolved from taskListLocalId at repo layer
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
    tags: const [], // resolved at repo layer
    syncStatus: syncStatus.name,
    syncStatusDisplay: null,
    lastSyncedAt: lastSyncedAt?.toIso8601String(),
    createdAt: createdAt?.toIso8601String(),
    updatedAt: updatedAt?.toIso8601String(),
  );
}

extension TodoItemEntityMapper on TodoItemEntity {
  TodoItem toDataModel({bool isDirty = true}) => TodoItem(
    localId: localId,
    id: id,
    taskListLocalId: taskListLocalId,
    title: title,
    notes: notes,
    status: status,
    priority: priority,
    due: due,
    completed: completed,
    subtaskCount: subtaskCount,
    position: position,
    hidden: hidden,
    syncStatus: syncStatus,
    lastSyncedAt: lastSyncedAt,
    createdAt: createdAt,
    updatedAt: updatedAt,
    isPendingDeletion: isPendingDeletion,
    isDirty: isDirty,
  );
}

extension TodoItemDtoMapper on TodoItemDto {
  /// [taskListLocalId] must be passed in — the DTO only carries
  /// the remote task_list UUID which you resolve at the repo layer.
  TodoItemEntity toEntity({
    int localId = 0,
    required int taskListLocalId,
    List<TodoTagEntity> tags = const [],
  }) => TodoItemEntity(
    localId: localId,
    id: id,
    taskListLocalId: taskListLocalId,
    title: title,
    notes: notes,
    status: _parseStatus(status),
    priority: _parsePriority(priority),
    due: due != null ? DateTime.tryParse(due!) : null,
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
  );

  /// Converts directly to a Drift data class, resolving
  /// [taskListLocalId] at the repo layer.
  TodoItem toDataModel({
    int localId = 0,
    required int taskListLocalId,
    bool isDirty = false,
    bool isPendingDeletion = false,
  }) => TodoItem(
    localId: localId,
    id: id,
    taskListLocalId: taskListLocalId,
    title: title,
    notes: notes,
    status: _parseStatus(status),
    priority: _parsePriority(priority),
    due: due != null ? DateTime.tryParse(due!) : null,
    completed: completed != null ? DateTime.tryParse(completed!) : null,
    subtaskCount: subtaskCount,
    position: position,
    hidden: hidden,
    syncStatus: _parseSyncStatus(syncStatus),
    lastSyncedAt: lastSyncedAt != null
        ? DateTime.tryParse(lastSyncedAt!)
        : null,
    createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
    updatedAt: updatedAt != null ? DateTime.tryParse(updatedAt!) : null,
    isPendingDeletion: isPendingDeletion,
    isDirty: isDirty,
  );

  TodoStatus _parseStatus(String? value) => TodoStatus.values.firstWhere(
    (e) => e.name == value?.toLowerCase(),
    orElse: () => TodoStatus.needsAction,
  );

  TodoPriority _parsePriority(String? value) => TodoPriority.values.firstWhere(
    (e) => e.name == value?.toLowerCase(),
    orElse: () => TodoPriority.none,
  );

  SyncStatus _parseSyncStatus(String? value) => SyncStatus.values.firstWhere(
    (e) => e.name == value?.toLowerCase(),
    orElse: () => SyncStatus.pending,
  );
}

extension TodoItemEntityToDto on TodoItemEntity {
  TodoItemDto toDto() => TodoItemDto(
    id: id,
    taskList: null, // resolved at repo layer from taskListLocalId
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
    tags: tags.map((t) => t.id ?? '').where((id) => id.isNotEmpty).toList(),
    syncStatus: syncStatus.name,
    syncStatusDisplay: null,
    lastSyncedAt: lastSyncedAt?.toIso8601String(),
    createdAt: createdAt?.toIso8601String(),
    updatedAt: updatedAt?.toIso8601String(),
  );
}
