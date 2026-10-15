import 'package:injectable/injectable.dart';
import 'package:core/core.dart';
import 'package:todos/src/domain/domain.dart';
import 'package:dartz/dartz.dart';

class AddFocusedTimeToTodoItemParams {
  final int todoLocalId;
  final Duration duration;

  const AddFocusedTimeToTodoItemParams({
    required this.todoLocalId,
    required this.duration,
  });
}

@injectable
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
