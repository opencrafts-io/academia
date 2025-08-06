import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/todos/todos.dart';
import 'package:dartz/dartz.dart';

class RefreshTodosParams {
  final int page;
  final int pageSize;

  RefreshTodosParams({required this.page, required this.pageSize});
}

class RefreshTodosUsecase
    implements UseCase<Stream<List<Todo>>, RefreshTodosParams> {
  final TodoRepository todoRepository;
  RefreshTodosUsecase({required this.todoRepository});

  @override
  Future<Either<Failure, Stream<List<Todo>>>> call(RefreshTodosParams params) {
    return todoRepository.refreshTodos(
      pageSize: params.pageSize,
      page: params.page,
    );
  }
}
