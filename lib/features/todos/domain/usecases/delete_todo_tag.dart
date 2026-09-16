import 'package:academia/core/core.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:dartz/dartz.dart';

class DeleteTodoTag extends UseCase<Unit, int> {
  final TodoTagRepository repository;
  DeleteTodoTag(this.repository);

  @override
  Future<Either<Failure, Unit>> call(int localId) async {
    return await repository.deleteTag(localId);
  }
}
