import 'package:injectable/injectable.dart';
import 'package:core/core.dart';
import 'package:todos/src/domain/domain.dart';
import 'package:dartz/dartz.dart';

class MoveTodoItemParams {
  final int localId;
  final int targetListLocalId;

  const MoveTodoItemParams({
    required this.localId,
    required this.targetListLocalId,
  });
}

@injectable
class MoveTodoItem extends UseCase<TodoItemEntity, MoveTodoItemParams> {
  final TodoItemRepository repository;
  MoveTodoItem(this.repository);

  @override
  Future<Either<Failure, TodoItemEntity>> call(
    MoveTodoItemParams params,
  ) async {
    return await repository.moveTodoItem(
      localId: params.localId,
      targetListLocalId: params.targetListLocalId,
    );
  }
}
