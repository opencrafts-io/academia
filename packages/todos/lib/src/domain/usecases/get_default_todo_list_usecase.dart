import 'package:injectable/injectable.dart';
import 'package:core/core.dart';
import 'package:todos/todos.dart';
import 'package:dartz/dartz.dart';

@injectable
class GetDefaultTodoListUsecase extends UseCase<TodoListEntity, NoParams> {
  final TodoListRepository repository;

  GetDefaultTodoListUsecase(this.repository);

  @override
  Future<Either<Failure, TodoListEntity>> call(NoParams params) async {
    return await repository.getDefaultTodoList();
  }
}
