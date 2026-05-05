import 'package:academia/core/core.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:dartz/dartz.dart';

class ReopenTodoItem extends UseCase<TodoItemEntity, int> {
  final TodoItemRepository repository;
  ReopenTodoItem(this.repository);

  @override
  Future<Either<Failure, TodoItemEntity>> call(int localId) async {
    return await repository.reopenTodoItem(localId);
  }
}
