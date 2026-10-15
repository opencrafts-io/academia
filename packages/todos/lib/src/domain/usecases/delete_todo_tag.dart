import 'package:injectable/injectable.dart';
import 'package:core/core.dart';
import 'package:todos/src/domain/domain.dart';
import 'package:dartz/dartz.dart';

@injectable
class DeleteTodoTag extends UseCase<Unit, int> {
  final TodoTagRepository repository;
  DeleteTodoTag(this.repository);

  @override
  Future<Either<Failure, Unit>> call(int localId) async {
    return await repository.deleteTag(localId);
  }
}
