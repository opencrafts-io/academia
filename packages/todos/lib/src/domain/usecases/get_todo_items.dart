import 'package:injectable/injectable.dart';

import 'package:core/core.dart';
import 'package:todos/src/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetTodoItemsParams {
  final String? url;
  final String? taskListId;
  final int? taskListLocalId;

  const GetTodoItemsParams({this.url, this.taskListId, this.taskListLocalId});
}

@injectable
class GetTodoItems extends UseCase<TodoItemPage, GetTodoItemsParams> {
  final TodoItemRepository repository;
  GetTodoItems(this.repository);

  @override
  Future<Either<Failure, TodoItemPage>> call(GetTodoItemsParams params) async {
    return await repository.getTodoItems(
      url: params.url,
      taskListId: params.taskListId,
      taskListLocalId: params.taskListLocalId,
    );
  }
}
