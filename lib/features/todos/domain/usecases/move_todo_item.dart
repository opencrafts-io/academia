import 'package:academia/core/core.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:dartz/dartz.dart';

class MoveTodoItemParams {
  final int localId;
  final int targetListLocalId;

  const MoveTodoItemParams({
    required this.localId,
    required this.targetListLocalId,
  });
}

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
