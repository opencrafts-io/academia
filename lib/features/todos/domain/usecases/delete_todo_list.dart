import 'package:academia/core/core.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:dartz/dartz.dart';

class DeleteTodoList extends UseCase<Unit, String> {
  final TodoListRepository repository;

  DeleteTodoList(this.repository);

  @override
  Future<Either<Failure, Unit>> call(String id) async {
    return await repository.deleteTodoList(id);
  }
}
