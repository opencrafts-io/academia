import 'package:injectable/injectable.dart';
import 'package:core/core.dart';
import 'package:todos/src/domain/domain.dart';
import 'package:dartz/dartz.dart';

@injectable
class UpdateTodoList extends UseCase<TodoListEntity, TodoListEntity> {
  final TodoListRepository repository;

  UpdateTodoList(this.repository);

  @override
  Future<Either<Failure, TodoListEntity>> call(TodoListEntity params) async {
    return await repository.updateTodoList(params);
  }
}
