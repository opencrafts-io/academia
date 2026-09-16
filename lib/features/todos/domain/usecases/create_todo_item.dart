import 'package:academia/core/core.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:dartz/dartz.dart';

class CreateTodoItem extends UseCase<TodoItemEntity, TodoItemEntity> {
  final TodoItemRepository repository;
  CreateTodoItem(this.repository);

  @override
  Future<Either<Failure, TodoItemEntity>> call(TodoItemEntity params) async {
    return await repository.createTodoItem(params);
  }
}
