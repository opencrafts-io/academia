import 'package:injectable/injectable.dart';
import 'package:core/core.dart';
import 'package:todos/src/domain/domain.dart';
import 'package:dartz/dartz.dart';

@injectable
class CreateTodoItem extends UseCase<TodoItemEntity, TodoItemEntity> {
  final TodoItemRepository repository;
  CreateTodoItem(this.repository);

  @override
  Future<Either<Failure, TodoItemEntity>> call(TodoItemEntity params) async {
    return await repository.createTodoItem(params);
  }
}
