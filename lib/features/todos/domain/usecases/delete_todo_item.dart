import 'package:academia/core/core.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:dartz/dartz.dart';

class DeleteTodoItem extends UseCase<Unit, int> {
  final TodoItemRepository repository;
  DeleteTodoItem(this.repository);

  @override
  Future<Either<Failure, Unit>> call(int localId) async {
    return await repository.deleteTodoItem(localId);
  }
}
