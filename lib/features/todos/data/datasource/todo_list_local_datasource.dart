import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class TodoListLocalDatasource {
  final AppDataBase cacheDB;
  TodoListLocalDatasource({required this.cacheDB});

  Future<Either<Failure, TodoList>> createTodo(TodoList todo) async {
    try {
      final companion = todo
          .toCompanion(true)
          .copyWith(localId: const Value.absent(), isDirty: const Value(true));
      final todoList = await cacheDB
          .into(cacheDB.todoLists)
          .insertReturning(companion, mode: InsertMode.insert);
      return right(todoList);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to create your todo at the moment. "
              "Clearing your phone's storage might fix this",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, List<TodoList>>> getTodoLists({
    bool? isDirty,
    bool? isPendingDeletion,
  }) async {
    try {
      final query = cacheDB.select(cacheDB.todoLists);

      query.where((t) {
        final conditions = <Expression<bool>>[];

        if (isDirty != null) {
          conditions.add(t.isDirty.equals(isDirty));
        }
        if (isPendingDeletion != null) {
          conditions.add(t.isPendingDeletion.equals(isPendingDeletion));
        }

        if (conditions.isEmpty) {
          return Constant(true);
        }

        return conditions.reduce((a, b) => a & b);
      });

      query.orderBy([
        (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
        (t) => OrderingTerm(expression: t.title, mode: OrderingMode.asc),
      ]);

      final result = await query.get();
      return Right(result);
    } catch (e) {
      return Left(
        CacheFailure(message: "Failed to retrieve your todo lists.", error: e),
      );
    }
  }

  // Retrieves a todo by its local id.
  Future<Either<Failure, TodoList?>> getTodoByID(int id) async {
    try {
      final todoList =
          await (cacheDB.todoLists.select()
                ..where((todoList) => todoList.localId.equals(id)))
              .getSingleOrNull();

      return Right(todoList);
    } catch (e) {
      return Left(
        CacheFailure(message: "Failed to retrieve todo list.", error: e),
      );
    }
  }

  Future<Either<Failure, TodoList?>> getTodoListByExternalID(String id) async {
    try {
      final todoList =
          await (cacheDB.todoLists.select()
                ..where((todoList) => todoList.id.equals(id)))
              .getSingleOrNull();

      return Right(todoList);
    } catch (e) {
      return Left(
        CacheFailure(
          message:
              "Something went wrong while attempting to retrieve todo list",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, TodoList>> updateTodoList(TodoList todoList) async {
    try {
      final companion = todoList.toCompanion(true);

      final rowsAffected = await (cacheDB.update(
        cacheDB.todoLists,
      )..where((t) => t.localId.equals(todoList.localId))).write(companion);

      if (rowsAffected > 0) {
        final updatedEntity = await (cacheDB.select(
          cacheDB.todoLists,
        )..where((t) => t.localId.equals(todoList.localId))).getSingle();

        return Right(updatedEntity);
      } else {
        return Left(
          CacheFailure(
            message: "No TodoList found with ID ${todoList.localId}",
            error: Exception("Update failed: 0 rows affected"),
          ),
        );
      }
    } catch (e) {
      return Left(
        CacheFailure(message: "Couldn't update todo at the moment", error: e),
      );
    }
  }

  Future<Either<Failure, TodoList>> softDeleteTodoList(
    TodoList todoList,
  ) async {
    try {
      final companion = todoList
          .toCompanion(true)
          .copyWith(
            isPendingDeletion: const Value(true),
            isDirty: const Value(true),
          );

      final rowsAffected = await (cacheDB.update(
        cacheDB.todoLists,
      )..where((t) => t.localId.equals(todoList.localId))).write(companion);

      if (rowsAffected > 0) {
        final updatedEntity = await (cacheDB.select(
          cacheDB.todoLists,
        )..where((t) => t.localId.equals(todoList.localId))).getSingle();

        return Right(updatedEntity);
      } else {
        return Left(
          CacheFailure(
            message: "Could not find todo list to mark for deletion",
            error: Exception("No TodoList found with ID ${todoList.localId}"),
          ),
        );
      }
    } catch (e) {
      return Left(
        CacheFailure(message: "Failed to set pending deletion", error: e),
      );
    }
  }

  Future<Either<Failure, Unit>> hardDeleteTodoList(int localId) async {
    try {
      final rowsDeleted = await (cacheDB.delete(
        cacheDB.todoLists,
      )..where((t) => t.localId.equals(localId))).go();

      if (rowsDeleted > 0) {
        return const Right(unit);
      } else {
        return Left(
          CacheFailure(
            message: "No TodoList found to delete",
            error: Exception("Record with ID $localId does not exist"),
          ),
        );
      }
    } catch (e) {
      return Left(
        CacheFailure(message: "Database error during hard delete", error: e),
      );
    }
  }
}
