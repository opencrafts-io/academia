import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class TodoLocalDatasource {
  final AppDataBase localDB;

  TodoLocalDatasource({required this.localDB});

  Stream<List<TodoData>> getTodosStream() {
    return (localDB.select(localDB.todo)..orderBy([
          (todo) => OrderingTerm(expression: todo.position, mode: OrderingMode.asc),
          // (todo) => OrderingTerm(expression: todo.updated, mode: OrderingMode.desc),
        ]))
        .watch();
  }

  Future<Either<Failure, TodoData>> createOrUpdateTodo(TodoData todo) async {
    try {
      final created = await localDB
          .into(localDB.todo)
          .insertReturning(todo, onConflict: DoUpdate((t) => todo));
      return right(created);
    } catch (e) {
      rethrow;
      return left(
        CacheFailure(
          error: e,
          message:
              "Looks like we tripped! We couldn't create a todo at the moment",
        ),
      );
    }
  }

  Future<Either<Failure, void>> deleteTodo(TodoData todo) async {
    try {
      await (localDB.delete(
        localDB.todo,
      )..where((t) => t.id.equals(todo.id))).go();
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              "A tiny glitch in the matrix stopped us from deleting your todo locally.",
        ),
      );
    }
  }
}
