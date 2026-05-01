import 'package:academia/core/core.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:dartz/dartz.dart';

class SyncTodoLists extends UseCase<Unit, NoParams> {
  final TodoListRepository repository;

  SyncTodoLists(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await repository.syncTodoLists();
  }
}
