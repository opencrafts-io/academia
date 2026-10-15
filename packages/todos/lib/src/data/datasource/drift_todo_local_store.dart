import 'package:core/core.dart';
import 'package:database/app_database_v2.dart' as db;
import 'package:database/daos/daos.dart';
import 'package:database/database.dart' show Value;
import 'package:dartz/dartz.dart';
import 'package:todos/domain.dart';

import 'package:todos/src/data/datasource/todo_local_store.dart';

/// Todo persistence backed by the shared database package's Drift DAOs.
class DriftTodoLocalStore implements TodoLocalStore {
  DriftTodoLocalStore({
    required this._lists,
    required this._items,
    required this._tags,
  });

  final TodoListDao _lists;
  final TodoItemDao _items;
  final TodoTagDao _tags;

  Future<Either<Failure, T>> _run<T>(
    Future<T> Function() operation,
    String message,
  ) async {
    try {
      return Right(await operation());
    } catch (error, stackTrace) {
      return Left(
        Failure.cache(message: message, error: error, stackTrace: stackTrace),
      );
    }
  }

  SyncStatus _syncStatus(String value) => SyncStatus.values.firstWhere(
    (status) => status.name == value.toLowerCase(),
    orElse: () => SyncStatus.pending,
  );

  TodoStatus _status(String value) => TodoStatus.values.firstWhere(
    (status) => status.name == value.toLowerCase(),
    orElse: () => TodoStatus.needsAction,
  );

  TodoPriority _priority(String value) => TodoPriority.values.firstWhere(
    (priority) => priority.name == value.toLowerCase(),
    orElse: () => TodoPriority.none,
  );

  TodoListEntity _listEntity(db.TodoList row) => TodoListEntity(
    localId: row.localId,
    id: row.id,
    title: row.title,
    color: row.color,
    isDefault: row.isDefault,
    syncStatus: _syncStatus(row.syncStatus),
    taskCount: row.taskCount,
    lastSyncedAt: row.lastSyncedAt,
    createdAt: row.createdAt,
    updatedAt: row.updatedAt,
    isPendingDeletion: row.isPendingDeletion,
    isDirty: row.isDirty,
  );

  TodoTagEntity _tagEntity(db.TodoTagItem row) => TodoTagEntity(
    localId: row.localId,
    id: row.id,
    name: row.name,
    color: row.color,
    syncStatus: _syncStatus(row.syncStatus),
    createdAt: row.createdAt,
    isPendingDeletion: row.isPendingDeletion,
    isDirty: row.isDirty,
  );

  TodoItemEntity _itemEntity(db.TodoItem row) => TodoItemEntity(
    localId: row.localId,
    id: row.id,
    taskListLocalId: row.taskListLocalId,
    title: row.title,
    notes: row.notes,
    status: _status(row.status),
    priority: _priority(row.priority),
    due: row.due,
    completed: row.completed,
    subtaskCount: row.subtaskCount,
    position: row.position,
    hidden: row.hidden,
    syncStatus: _syncStatus(row.syncStatus),
    lastSyncedAt: row.lastSyncedAt,
    createdAt: row.createdAt,
    updatedAt: row.updatedAt,
    isPendingDeletion: row.isPendingDeletion,
    isDirty: row.isDirty,
    focusedSeconds: row.focusedSeconds,
  );

  db.TodoListsCompanion _listCompanion(TodoListEntity list) =>
      db.TodoListsCompanion(
        localId: Value(list.localId),
        id: Value(list.id),
        title: Value(list.title),
        color: Value(list.color),
        isDefault: Value(list.isDefault),
        syncStatus: Value(list.syncStatus.name),
        taskCount: Value(list.taskCount),
        lastSyncedAt: Value(list.lastSyncedAt),
        createdAt: Value(list.createdAt),
        updatedAt: Value(list.updatedAt),
        isPendingDeletion: Value(list.isPendingDeletion),
        isDirty: Value(list.isDirty),
      );

  db.TodoTagItemsCompanion _tagCompanion(TodoTagEntity tag) =>
      db.TodoTagItemsCompanion(
        localId: Value(tag.localId),
        id: Value(tag.id),
        name: Value(tag.name),
        color: Value(tag.color),
        syncStatus: Value(tag.syncStatus.name),
        createdAt: Value(tag.createdAt),
        isPendingDeletion: Value(tag.isPendingDeletion),
        isDirty: Value(tag.isDirty),
      );

  db.TodoItemsCompanion _itemCompanion(TodoItemEntity item) =>
      db.TodoItemsCompanion(
        localId: Value(item.localId),
        id: Value(item.id),
        taskListLocalId: Value(item.taskListLocalId),
        title: Value(item.title),
        notes: Value(item.notes),
        status: Value(item.status.name),
        priority: Value(item.priority.name),
        due: Value(item.due),
        completed: Value(item.completed),
        subtaskCount: Value(item.subtaskCount),
        position: Value(item.position),
        hidden: Value(item.hidden),
        syncStatus: Value(item.syncStatus.name),
        lastSyncedAt: Value(item.lastSyncedAt),
        createdAt: Value(item.createdAt),
        updatedAt: Value(item.updatedAt),
        isPendingDeletion: Value(item.isPendingDeletion),
        isDirty: Value(item.isDirty),
        focusedSeconds: Value(item.focusedSeconds),
      );

  @override
  Future<Either<Failure, TodoListEntity>> createTodo(
    TodoListEntity todo,
  ) async => _run(
    () async => _listEntity(await _lists.create(_listCompanion(todo))),
    'Failed to create your todo list.',
  );

  @override
  Future<Either<Failure, List<TodoListEntity>>> getTodoLists({
    bool? isDirty,
    bool? isPendingDeletion,
  }) async => _run(
    () async => (await _lists.getAll(
      isDirty: isDirty,
      isPendingDeletion: isPendingDeletion,
    )).map(_listEntity).toList(),
    'Failed to retrieve your todo lists.',
  );

  @override
  Future<Either<Failure, TodoListEntity?>> getTodoByID(int id) async =>
      _run(() async {
        final row = await _lists.getByLocalId(id);
        return row == null ? null : _listEntity(row);
      }, 'Failed to retrieve todo list.');

  @override
  Future<Either<Failure, TodoListEntity?>> getTodoListByExternalID(
    String id,
  ) async => _run(() async {
    final row = await _lists.getById(id);
    return row == null ? null : _listEntity(row);
  }, 'Failed to retrieve todo list.');

  @override
  Future<Either<Failure, TodoListEntity>> updateTodoList(
    TodoListEntity todoList,
  ) async => _run(() async {
    final row = await _lists.updateList(
      _listCompanion(todoList),
      todoList.localId,
    );
    if (row == null) throw StateError('Todo list not found');
    return _listEntity(row);
  }, 'Could not update todo list.');

  @override
  Future<Either<Failure, TodoListEntity>> softDeleteTodoList(
    TodoListEntity todoList,
  ) async => _run(() async {
    final row = await _lists.softDelete(
      _listCompanion(todoList),
      todoList.localId,
    );
    if (row == null) throw StateError('Todo list not found');
    return _listEntity(row);
  }, 'Failed to mark todo list for deletion.');

  @override
  Future<Either<Failure, Unit>> hardDeleteTodoList(int localId) async =>
      _run(() async {
        final count = await _lists.hardDelete(localId);
        if (count == 0) throw StateError('Todo list not found');
        return unit;
      }, 'Failed to delete todo list.');

  @override
  Future<Either<Failure, TodoTagEntity>> createTag(TodoTagEntity tag) async =>
      _run(
        () async => _tagEntity(await _tags.create(_tagCompanion(tag))),
        'Failed to create todo tag.',
      );

  @override
  Future<Either<Failure, List<TodoTagEntity>>> getTags({
    bool? isDirty,
    bool? isPendingDeletion,
  }) async => _run(
    () async => (await _tags.getAll(
      isDirty: isDirty,
      isPendingDeletion: isPendingDeletion,
    )).map(_tagEntity).toList(),
    'Failed to retrieve todo tags.',
  );

  @override
  Future<Either<Failure, TodoTagEntity?>> getTagByID(int id) async =>
      _run(() async {
        final row = await _tags.getByLocalId(id);
        return row == null ? null : _tagEntity(row);
      }, 'Failed to retrieve todo tag.');

  @override
  Future<Either<Failure, TodoTagEntity?>> getTagByExternalID(String id) async =>
      _run(() async {
        final row = await _tags.getById(id);
        return row == null ? null : _tagEntity(row);
      }, 'Failed to retrieve todo tag.');

  @override
  Future<Either<Failure, TodoTagEntity>> updateTag(TodoTagEntity tag) async =>
      _run(() async {
        final row = await _tags.updateTag(_tagCompanion(tag), tag.localId);
        if (row == null) throw StateError('Todo tag not found');
        return _tagEntity(row);
      }, 'Could not update todo tag.');

  @override
  Future<Either<Failure, TodoTagEntity>> softDeleteTag(
    TodoTagEntity tag,
  ) async => _run(() async {
    final row = await _tags.softDelete(_tagCompanion(tag), tag.localId);
    if (row == null) throw StateError('Todo tag not found');
    return _tagEntity(row);
  }, 'Failed to mark todo tag for deletion.');

  @override
  Future<Either<Failure, Unit>> hardDeleteTag(int localId) async =>
      _run(() async {
        final count = await _tags.hardDelete(localId);
        if (count == 0) throw StateError('Todo tag not found');
        return unit;
      }, 'Failed to delete todo tag.');

  @override
  Future<Either<Failure, TodoItemEntity>> createTodoItem(
    TodoItemEntity item,
  ) async => _run(
    () async => _itemEntity(await _items.create(_itemCompanion(item))),
    'Failed to create todo item.',
  );

  @override
  Future<Either<Failure, List<TodoItemEntity>>> getTodoItems({
    int? taskListLocalId,
    bool? isDirty,
    bool? isPendingDeletion,
    TodoStatus? status,
    TodoPriority? priority,
  }) async => _run(
    () async => (await _items.getAll(
      taskListLocalId: taskListLocalId,
      isDirty: isDirty,
      isPendingDeletion: isPendingDeletion,
      status: status?.name,
      priority: priority?.name,
    )).map(_itemEntity).toList(),
    'Failed to retrieve todo items.',
  );

  @override
  Future<Either<Failure, TodoItemEntity?>> getTodoItemByID(int id) async =>
      _run(() async {
        final row = await _items.getByLocalId(id);
        return row == null ? null : _itemEntity(row);
      }, 'Failed to retrieve todo item.');

  @override
  Future<Either<Failure, TodoItemEntity?>> getTodoItemByExternalID(
    String id,
  ) async => _run(() async {
    final row = await _items.getById(id);
    return row == null ? null : _itemEntity(row);
  }, 'Failed to retrieve todo item.');

  @override
  Future<Either<Failure, TodoItemEntity>> updateTodoItem(
    TodoItemEntity item,
  ) async => _run(() async {
    final row = await _items.updateItem(_itemCompanion(item), item.localId);
    if (row == null) throw StateError('Todo item not found');
    return _itemEntity(row);
  }, 'Could not update todo item.');

  @override
  Future<Either<Failure, TodoItemEntity>> addFocusedTime(
    int localId,
    Duration duration,
  ) async => _run(() async {
    final row = await _items.addFocusedTime(localId, duration);
    if (row == null) throw StateError('Todo item not found');
    return _itemEntity(row);
  }, 'Could not save todo focus time.');

  @override
  Future<Either<Failure, TodoItemEntity>> softDeleteTodoItem(
    TodoItemEntity item,
  ) async => _run(() async {
    final row = await _items.softDelete(_itemCompanion(item), item.localId);
    if (row == null) throw StateError('Todo item not found');
    return _itemEntity(row);
  }, 'Failed to mark todo item for deletion.');

  @override
  Future<Either<Failure, Unit>> hardDeleteTodoItem(int localId) async =>
      _run(() async {
        final count = await _items.hardDelete(localId);
        if (count == 0) throw StateError('Todo item not found');
        return unit;
      }, 'Failed to delete todo item.');

  @override
  Future<Either<Failure, Unit>> addTagToTodoItem({
    required int todoLocalId,
    required int tagLocalId,
  }) async => _run(() async {
    await _items.addTag(todoLocalId: todoLocalId, tagLocalId: tagLocalId);
    return unit;
  }, 'Failed to add tag to todo item.');

  @override
  Future<Either<Failure, Unit>> removeTagFromTodoItem({
    required int todoLocalId,
    required int tagLocalId,
  }) async => _run(() async {
    await _items.removeTag(todoLocalId: todoLocalId, tagLocalId: tagLocalId);
    return unit;
  }, 'Failed to remove tag from todo item.');

  @override
  Future<Either<Failure, List<TodoTagEntity>>> getTagsForTodoItem(
    int todoLocalId,
  ) async => _run(
    () async => (await _items.getTags(todoLocalId)).map(_tagEntity).toList(),
    'Failed to retrieve tags for todo item.',
  );

  @override
  Future<Either<Failure, Unit>> syncTagsForTodoItem({
    required int todoLocalId,
    required List<int> tagLocalIds,
  }) async => _run(() async {
    await _items.replaceTags(
      todoLocalId: todoLocalId,
      tagLocalIds: tagLocalIds,
    );
    return unit;
  }, 'Failed to sync todo item tags.');
}
