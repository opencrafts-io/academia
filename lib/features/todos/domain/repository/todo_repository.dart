import 'package:academia/core/error/failures.dart';
import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';

abstract class TodoRepository {
  Future<Either<Failure, Todo>> createTodo(Todo todo);
  Future<Either<Failure, Stream<List<Todo>>>> refreshTodos({
    int page = 1,
    int pageSize = 100,
  });
  Stream<List<Todo>> getCachedTodos();
  Future<Either<Failure, Todo>> updateTodo(Todo todo);
  Future<Either<Failure, Todo>> completeTodo(Todo todo);
  Future<Either<Failure, Todo>> deleteTodo(Todo todo);
}
