import 'package:academia/core/core.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetTodoItemById extends UseCase<TodoItemEntity, String> {
  final TodoItemRepository repository;
  GetTodoItemById(this.repository);

  @override
  Future<Either<Failure, TodoItemEntity>> call(String id) async {
    return await repository.getTodoItemById(id);
  }
}
