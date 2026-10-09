import 'package:injectable/injectable.dart';
import 'package:core/core.dart';
import 'package:todos/src/domain/domain.dart';
import 'package:dartz/dartz.dart';

@injectable
class CreateTodoTag extends UseCase<TodoTagEntity, TodoTagEntity> {
  final TodoTagRepository repository;
  CreateTodoTag(this.repository);

  @override
  Future<Either<Failure, TodoTagEntity>> call(TodoTagEntity params) async {
    return await repository.createTag(params);
  }
}
