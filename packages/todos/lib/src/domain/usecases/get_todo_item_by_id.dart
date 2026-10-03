import 'package:injectable/injectable.dart';
import 'package:core/core.dart';
import 'package:todos/src/domain/domain.dart';
import 'package:dartz/dartz.dart';

@injectable
class GetTodoItemById extends UseCase<TodoItemEntity, String> {
  final TodoItemRepository repository;
  GetTodoItemById(this.repository);

  @override
  Future<Either<Failure, TodoItemEntity>> call(String id) async {
    return await repository.getTodoItemById(id);
  }
}
