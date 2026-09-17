import 'package:academia/core/core.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:dartz/dartz.dart';

class CompleteTodoItem extends UseCase<TodoItemEntity, int> {
  final TodoItemRepository repository;
  CompleteTodoItem(this.repository);

  @override
  Future<Either<Failure, TodoItemEntity>> call(int localId) async {
    return await repository.completeTodoItem(localId);
  }
}
