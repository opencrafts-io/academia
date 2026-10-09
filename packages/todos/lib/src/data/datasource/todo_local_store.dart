import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import 'package:todos/domain.dart';

/// Local persistence contract for todos.
///
/// The local cache is stored in the shared database package's v2 database.
/// Remote refresh repopulates this cache when the app starts or syncs.
abstract interface class TodoLocalStore {
  Future<Either<Failure, TodoListEntity>> createTodo(TodoListEntity todo);

  Future<Either<Failure, List<TodoListEntity>>> getTodoLists({
    bool? isDirty,
    bool? isPendingDeletion,
  });

  Future<Either<Failure, TodoListEntity?>> getTodoByID(int id);

  Future<Either<Failure, TodoListEntity?>> getTodoListByExternalID(String id);

  Future<Either<Failure, TodoListEntity>> updateTodoList(
    TodoListEntity todoList,
  );

  Future<Either<Failure, TodoListEntity>> softDeleteTodoList(
    TodoListEntity todoList,
  );

  Future<Either<Failure, Unit>> hardDeleteTodoList(int localId);

  Future<Either<Failure, TodoTagEntity>> createTag(TodoTagEntity tag);

  Future<Either<Failure, List<TodoTagEntity>>> getTags({
    bool? isDirty,
    bool? isPendingDeletion,
  });

  Future<Either<Failure, TodoTagEntity?>> getTagByID(int id);

  Future<Either<Failure, TodoTagEntity?>> getTagByExternalID(String id);

  Future<Either<Failure, TodoTagEntity>> updateTag(TodoTagEntity tag);

  Future<Either<Failure, TodoTagEntity>> softDeleteTag(TodoTagEntity tag);

  Future<Either<Failure, Unit>> hardDeleteTag(int localId);

  Future<Either<Failure, TodoItemEntity>> createTodoItem(TodoItemEntity item);

  Future<Either<Failure, List<TodoItemEntity>>> getTodoItems({
    int? taskListLocalId,
    bool? isDirty,
    bool? isPendingDeletion,
    TodoStatus? status,
    TodoPriority? priority,
  });

  Future<Either<Failure, TodoItemEntity?>> getTodoItemByID(int id);

  Future<Either<Failure, TodoItemEntity?>> getTodoItemByExternalID(String id);

  Future<Either<Failure, TodoItemEntity>> updateTodoItem(TodoItemEntity item);

  Future<Either<Failure, TodoItemEntity>> addFocusedTime(
    int localId,
    Duration duration,
  );

  Future<Either<Failure, TodoItemEntity>> softDeleteTodoItem(
    TodoItemEntity item,
  );

  Future<Either<Failure, Unit>> hardDeleteTodoItem(int localId);

  Future<Either<Failure, Unit>> addTagToTodoItem({
    required int todoLocalId,
    required int tagLocalId,
  });

  Future<Either<Failure, Unit>> removeTagFromTodoItem({
    required int todoLocalId,
    required int tagLocalId,
  });

  Future<Either<Failure, List<TodoTagEntity>>> getTagsForTodoItem(
    int todoLocalId,
  );

  Future<Either<Failure, Unit>> syncTagsForTodoItem({
    required int todoLocalId,
    required List<int> tagLocalIds,
  });
}
