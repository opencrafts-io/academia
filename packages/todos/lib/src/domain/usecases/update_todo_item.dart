import 'package:injectable/injectable.dart';
import 'package:core/core.dart';
import 'package:todos/src/domain/domain.dart';
import 'package:dartz/dartz.dart';

@injectable
class UpdateTodoItem extends UseCase<TodoItemEntity, TodoItemEntity> {
  final TodoItemRepository repository;
  UpdateTodoItem(this.repository);

  @override
  Future<Either<Failure, TodoItemEntity>> call(TodoItemEntity params) async {
    return await repository.updateTodoItem(params);
  }
}
