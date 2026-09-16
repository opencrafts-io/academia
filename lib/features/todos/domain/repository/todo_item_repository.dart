import 'package:academia/core/core.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:dartz/dartz.dart';

abstract class TodoItemRepository {
  /// Fetch tasks, optionally filtered by [taskListId] (remote UUID).
  /// Falls back to local cache filtered by [taskListLocalId] if offline.
  Future<Either<Failure, TodoItemPage>> getTodoItems({
    String? url,
    String? taskListId,
    int? taskListLocalId,
  });

  /// Fetch a single task by its remote UUID.
  Future<Either<Failure, TodoItemEntity>> getTodoItemById(String id);

  /// Local-first create. Syncs to remote in background.
  Future<Either<Failure, TodoItemEntity>> createTodoItem(TodoItemEntity entity);

  /// Local-first update. Syncs to remote in background.
  Future<Either<Failure, TodoItemEntity>> updateTodoItem(TodoItemEntity entity);

  /// Soft-deletes locally, hard-deletes after remote confirms.
  Future<Either<Failure, Unit>> deleteTodoItem(int localId);

  /// Marks a task complete locally then syncs to remote.
  Future<Either<Failure, TodoItemEntity>> completeTodoItem(int localId);

  /// Reopens a completed task locally then syncs to remote.
  Future<Either<Failure, TodoItemEntity>> reopenTodoItem(int localId);

  /// Moves a task to a different list locally then syncs to remote.
  Future<Either<Failure, TodoItemEntity>> moveTodoItem({
    required int localId,
    required int targetListLocalId,
  });

  /// Pushes all dirty/pending-deletion items to remote.
  Future<Either<Failure, Unit>> syncTodoItems();
}
