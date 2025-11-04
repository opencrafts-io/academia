import 'package:academia/core/data/paginated_result.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/todos/todos.dart';
import 'package:dartz/dartz.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDatasource todoLocalDatasource;
  final TodoRemoteDatasource todoRemoteDatasource;

  TodoRepositoryImpl({
    required this.todoRemoteDatasource,
    required this.todoLocalDatasource,
  });

  @override
  Stream<List<Todo>> getCachedTodos() {
    return todoLocalDatasource.getTodosStream().map(
      (rawTodos) => rawTodos.map((rawTodo) => rawTodo.toEntity()).toList(),
    );
  }

  @override
  Future<Either<Failure, Todo>> deleteTodo(Todo todo) async {
    final remoteRes = await todoRemoteDatasource.deleteTodo(todo.toModel());

    if (remoteRes.isLeft()) {
      return Left((remoteRes as Left).value);
    }

    final localRes = await todoLocalDatasource.deleteTodo(todo.toModel());
    return localRes.fold((failure) => left(failure), (t) => right(todo));
  }

  @override
  Future<Either<Failure, Todo>> updateTodo(Todo todo) async {
    final remoteRes = await todoRemoteDatasource.updateTodo(todo.toModel());

    if (remoteRes.isLeft()) {
      return Left((remoteRes as Left).value);
    }

    final localRes = await todoLocalDatasource.createOrUpdateTodo(
      (remoteRes as Right).value,
    );
    return localRes.fold(
      (failure) => left(failure),
      (updated) => right(updated.toEntity()),
    );
  }

  @override
  Future<Either<Failure, Todo>> createTodo(Todo todo) async {
    final remoteRes = await todoRemoteDatasource.createTodo(todo.toModel());

    if (remoteRes.isLeft()) {
      return Left((remoteRes as Left).value);
    }

    final updateLocalRes = await todoLocalDatasource.createOrUpdateTodo(
      (remoteRes as Right).value,
    );

    return updateLocalRes.fold(
      (failure) => left(failure),
      (created) => right(created.toEntity()),
    );
  }

  @override
  /// syncWithGoogleTasks
  /// Syncs todos with google calendar
  Future<Either<Failure, bool>> syncWithGoogleTasks() async {
    return todoRemoteDatasource.sync();
  }

  @override
  Future<Either<Failure, Stream<List<Todo>>>> refreshTodos({
    int page = 1,
    int pageSize = 100,
  }) async {
    final remoteRes = await todoRemoteDatasource.refreshTodos(
      page: page,
      pageSize: pageSize,
    );

    if (remoteRes.isLeft()) {
      return Left((remoteRes as Left).value);
    }

    final data = (remoteRes as Right).value as PaginatedResult<TodoData>;

    for (final todo in data.results) {
      final localRes = await todoLocalDatasource.createOrUpdateTodo(todo);
      if (localRes.isLeft()) {
        return left((localRes as Left).value);
      }
    }
    return Right(
      todoLocalDatasource.getTodosStream().map(
        (elem) => elem.map((todo) => todo.toEntity()).toList(),
      ),
    );
  }

  @override
  Future<Either<Failure, Todo>> completeTodo(Todo todo) async {
    final remoteRes = await todoRemoteDatasource.completeTodo(todo.toModel());

    if (remoteRes.isLeft()) {
      return Left((remoteRes as Left).value);
    }

    final localRes = await todoLocalDatasource.createOrUpdateTodo(
      (remoteRes as Right).value,
    );
    return localRes.fold(
      (failure) => left(failure),
      (completed) => right(completed.toEntity()),
    );
  }
}
