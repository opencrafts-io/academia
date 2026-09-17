import 'package:academia/core/core.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:dartz/dartz.dart';

class AddFocusedTimeToTodoItemParams {
  final int todoLocalId;
  final Duration duration;

  const AddFocusedTimeToTodoItemParams({
    required this.todoLocalId,
    required this.duration,
  });
}

class AddFocusedTimeToTodoItem
    extends UseCase<TodoItemEntity, AddFocusedTimeToTodoItemParams> {
  final TodoItemRepository repository;
  AddFocusedTimeToTodoItem(this.repository);

  @override
  Future<Either<Failure, TodoItemEntity>> call(
    AddFocusedTimeToTodoItemParams params,
  ) async {
    return await repository.addFocusedTime(
      todoLocalId: params.todoLocalId,
      duration: params.duration,
    );
  }
}
