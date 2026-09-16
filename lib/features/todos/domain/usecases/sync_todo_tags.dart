import 'package:academia/core/core.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:dartz/dartz.dart';

class SyncTodoTags extends UseCase<Unit, NoParams> {
  final TodoTagRepository repository;
  SyncTodoTags(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await repository.syncTags();
  }
}
