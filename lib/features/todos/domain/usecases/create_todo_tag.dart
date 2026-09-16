import 'package:academia/core/core.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:dartz/dartz.dart';

class CreateTodoTag extends UseCase<TodoTagEntity, TodoTagEntity> {
  final TodoTagRepository repository;
  CreateTodoTag(this.repository);

  @override
  Future<Either<Failure, TodoTagEntity>> call(TodoTagEntity params) async {
    return await repository.createTag(params);
  }
}
