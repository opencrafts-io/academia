import 'package:injectable/injectable.dart';
import 'package:core/core.dart';
import 'package:todos/src/domain/domain.dart';
import 'package:dartz/dartz.dart';

@injectable
class DeleteTodoList extends UseCase<Unit, int> {
  final TodoListRepository repository;

  DeleteTodoList(this.repository);

  @override
  Future<Either<Failure, Unit>> call(int localId) async {
    return await repository.deleteTodoList(localId);
  }
}
