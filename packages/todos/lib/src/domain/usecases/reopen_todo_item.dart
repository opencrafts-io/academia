import 'package:injectable/injectable.dart';
import 'package:core/core.dart';
import 'package:todos/src/domain/domain.dart';
import 'package:dartz/dartz.dart';

@injectable
class ReopenTodoItem extends UseCase<TodoItemEntity, int> {
  final TodoItemRepository repository;
  ReopenTodoItem(this.repository);

  @override
  Future<Either<Failure, TodoItemEntity>> call(int localId) async {
    return await repository.reopenTodoItem(localId);
  }
}
