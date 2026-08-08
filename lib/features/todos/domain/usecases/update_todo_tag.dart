import 'package:academia/core/core.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:dartz/dartz.dart';

class UpdateTodoTag extends UseCase<TodoTagEntity, TodoTagEntity> {
  final TodoTagRepository repository;
  UpdateTodoTag(this.repository);

  @override
  Future<Either<Failure, TodoTagEntity>> call(TodoTagEntity params) async {
    return await repository.updateTag(params);
  }
}
