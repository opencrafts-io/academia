import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class TodoItemLocalDatasource {
  final AppDataBase cacheDB;
  TodoItemLocalDatasource({required this.cacheDB});

  Future<Either<Failure, TodoItem>> createTodoItem(TodoItem item) async {
    try {
      final companion = item
          .toCompanion(true)
          .copyWith(localId: const Value.absent(), isDirty: const Value(true));
      final result = await cacheDB
          .into(cacheDB.todoItems)
          .insertReturning(companion, mode: InsertMode.insert);
      return right(result);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to create your todo item at the moment. "
              "Clearing your phone's storage might fix this",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, List<TodoItem>>> getTodoItems({
    int? taskListLocalId,
    bool? isDirty,
    bool? isPendingDeletion,
    TodoStatus? status,
    TodoPriority? priority,
  }) async {
    try {
      final query = cacheDB.select(cacheDB.todoItems);

      query.where((t) {
        final conditions = <Expression<bool>>[];

        if (taskListLocalId != null) {
          conditions.add(t.taskListLocalId.equals(taskListLocalId));
        }
        if (isDirty != null) {
          conditions.add(t.isDirty.equals(isDirty));
        }
        if (isPendingDeletion != null) {
          conditions.add(t.isPendingDeletion.equals(isPendingDeletion));
        }
        if (status != null) {
          conditions.add(t.status.equalsValue(status));
        }
        if (priority != null) {
          conditions.add(t.priority.equalsValue(priority));
        }

        if (conditions.isEmpty) return const Constant(true);
        return conditions.reduce((a, b) => a & b);
      });

      query.orderBy([
        (t) => OrderingTerm(expression: t.due, mode: OrderingMode.asc),
        (t) => OrderingTerm(expression: t.position, mode: OrderingMode.asc),
        (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
      ]);

      final result = await query.get();
      return right(result);
    } catch (e) {
      return left(
        CacheFailure(message: "Failed to retrieve your todo items.", error: e),
      );
    }
  }

  Future<Either<Failure, TodoItem?>> getTodoItemByID(int id) async {
    try {
      final item =
          await (cacheDB.todoItems.select()..where((t) => t.localId.equals(id)))
              .getSingleOrNull();
      return right(item);
    } catch (e) {
      return left(
        CacheFailure(message: "Failed to retrieve todo item.", error: e),
      );
    }
  }

  Future<Either<Failure, TodoItem?>> getTodoItemByExternalID(String id) async {
    try {
      final item =
          await (cacheDB.todoItems.select()..where((t) => t.id.equals(id)))
              .getSingleOrNull();
      return right(item);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Something went wrong while attempting to retrieve todo item",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, TodoItem>> updateTodoItem(TodoItem item) async {
    try {
      final companion = item.toCompanion(true);

      final rowsAffected = await (cacheDB.update(
        cacheDB.todoItems,
      )..where((t) => t.localId.equals(item.localId))).write(companion);

      if (rowsAffected > 0) {
        final updated = await (cacheDB.select(
          cacheDB.todoItems,
        )..where((t) => t.localId.equals(item.localId))).getSingle();
        return right(updated);
      } else {
        return left(
          CacheFailure(
            message: "No todo item found with ID ${item.localId}",
            error: Exception("Update failed: 0 rows affected"),
          ),
        );
      }
    } catch (e) {
      return left(
        CacheFailure(
          message: "Couldn't update todo item at the moment",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, TodoItem>> softDeleteTodoItem(TodoItem item) async {
    try {
      final companion = item
          .toCompanion(true)
          .copyWith(
            isPendingDeletion: const Value(true),
            isDirty: const Value(true),
          );

      final rowsAffected = await (cacheDB.update(
        cacheDB.todoItems,
      )..where((t) => t.localId.equals(item.localId))).write(companion);

      if (rowsAffected > 0) {
        final updated = await (cacheDB.select(
          cacheDB.todoItems,
        )..where((t) => t.localId.equals(item.localId))).getSingle();
        return right(updated);
      } else {
        return left(
          CacheFailure(
            message: "Could not find todo item to mark for deletion",
            error: Exception("No todo item found with ID ${item.localId}"),
          ),
        );
      }
    } catch (e) {
      return left(
        CacheFailure(message: "Failed to set pending deletion", error: e),
      );
    }
  }

  Future<Either<Failure, Unit>> hardDeleteTodoItem(int localId) async {
    try {
      final rowsDeleted = await (cacheDB.delete(
        cacheDB.todoItems,
      )..where((t) => t.localId.equals(localId))).go();

      if (rowsDeleted > 0) {
        return const Right(unit);
      } else {
        return left(
          CacheFailure(
            message: "No todo item found to delete",
            error: Exception("Record with ID $localId does not exist"),
          ),
        );
      }
    } catch (e) {
      return left(
        CacheFailure(message: "Database error during hard delete", error: e),
      );
    }
  }

  // --- Junction table helpers for tags ---

  Future<Either<Failure, Unit>> addTagToTodoItem({
    required int todoLocalId,
    required int tagLocalId,
  }) async {
    try {
      await cacheDB
          .into(cacheDB.todoItemTags)
          .insert(
            TodoItemTagsCompanion.insert(
              todoLocalId: todoLocalId,
              tagLocalId: tagLocalId,
            ),
            mode: InsertMode.insertOrIgnore,
          );
      return const Right(unit);
    } catch (e) {
      return left(
        CacheFailure(message: "Failed to add tag to todo item", error: e),
      );
    }
  }

  Future<Either<Failure, Unit>> removeTagFromTodoItem({
    required int todoLocalId,
    required int tagLocalId,
  }) async {
    try {
      await (cacheDB.delete(cacheDB.todoItemTags)..where(
            (t) =>
                t.todoLocalId.equals(todoLocalId) &
                t.tagLocalId.equals(tagLocalId),
          ))
          .go();
      return const Right(unit);
    } catch (e) {
      return left(
        CacheFailure(message: "Failed to remove tag from todo item", error: e),
      );
    }
  }

  Future<Either<Failure, List<TodoTagItem>>> getTagsForTodoItem(
    int todoLocalId,
  ) async {
    try {
      final query = cacheDB.select(cacheDB.todoItemTags).join([
        innerJoin(
          cacheDB.todoTagItems,
          cacheDB.todoTagItems.localId.equalsExp(
            cacheDB.todoItemTags.tagLocalId,
          ),
        ),
      ])..where(cacheDB.todoItemTags.todoLocalId.equals(todoLocalId));

      final rows = await query.get();
      final tags = rows
          .map((row) => row.readTable(cacheDB.todoTagItems))
          .toList();
      return right(tags);
    } catch (e) {
      return left(
        CacheFailure(
          message: "Failed to retrieve tags for todo item",
          error: e,
        ),
      );
    }
  }

  /// Replaces all tags for a todo item in a single transaction.
  Future<Either<Failure, Unit>> syncTagsForTodoItem({
    required int todoLocalId,
    required List<int> tagLocalIds,
  }) async {
    try {
      await cacheDB.transaction(() async {
        await (cacheDB.delete(
          cacheDB.todoItemTags,
        )..where((t) => t.todoLocalId.equals(todoLocalId))).go();

        for (final tagId in tagLocalIds) {
          await cacheDB
              .into(cacheDB.todoItemTags)
              .insert(
                TodoItemTagsCompanion.insert(
                  todoLocalId: todoLocalId,
                  tagLocalId: tagId,
                ),
              );
        }
      });
      return const Right(unit);
    } catch (e) {
      return left(
        CacheFailure(message: "Failed to sync tags for todo item", error: e),
      );
    }
  }
}
