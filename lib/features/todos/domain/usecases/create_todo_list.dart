import 'package:academia/core/core.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:dartz/dartz.dart';

class CreateTodoList extends UseCase<TodoListEntity, TodoListEntity> {
  final TodoListRepository repository;

  CreateTodoList(this.repository);

  @override
  Future<Either<Failure, TodoListEntity>> call(TodoListEntity params) async {
    return await repository.createTodoList(params);
  }
}
