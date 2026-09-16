import 'package:academia/core/core.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:dartz/dartz.dart';

class DeleteTodoList extends UseCase<Unit, int> {
  final TodoListRepository repository;

  DeleteTodoList(this.repository);

  @override
  Future<Either<Failure, Unit>> call(int localId) async {
    return await repository.deleteTodoList(localId);
  }
}
