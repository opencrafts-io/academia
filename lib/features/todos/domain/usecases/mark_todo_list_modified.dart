import 'package:academia/core/core.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:dartz/dartz.dart';

/// Records that a todo list was just modified (e.g. a new item was added
/// to it) by bumping its `updatedAt` timestamp, so it sorts to the front
/// as "recently updated".
class MarkTodoListModified extends UseCase<TodoListEntity, int> {
  final TodoListRepository repository;

  MarkTodoListModified(this.repository);

  @override
  Future<Either<Failure, TodoListEntity>> call(int params) async {
    return await repository.markTodoListModified(params);
  }
}
