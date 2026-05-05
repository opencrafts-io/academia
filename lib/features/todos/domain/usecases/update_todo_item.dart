import 'package:academia/core/core.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:dartz/dartz.dart';

class UpdateTodoItem extends UseCase<TodoItemEntity, TodoItemEntity> {
  final TodoItemRepository repository;
  UpdateTodoItem(this.repository);

  @override
  Future<Either<Failure, TodoItemEntity>> call(TodoItemEntity params) async {
    return await repository.updateTodoItem(params);
  }
}
