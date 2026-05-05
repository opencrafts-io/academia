import 'package:academia/core/core.dart';
import 'package:academia/features/todos/todos.dart';
import 'package:dartz/dartz.dart';

class GetDefaultTodoListUsecase extends UseCase<TodoListEntity, NoParams> {
  final TodoListRepository repository;

  GetDefaultTodoListUsecase(this.repository);

  @override
  Future<Either<Failure, TodoListEntity>> call(NoParams params) async {
    return await repository.getDefaultTodoList();
  }
}
