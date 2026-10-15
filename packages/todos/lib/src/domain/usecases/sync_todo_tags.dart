import 'package:injectable/injectable.dart';
import 'package:core/core.dart';
import 'package:todos/src/domain/domain.dart';
import 'package:dartz/dartz.dart';

@injectable
class SyncTodoTags extends UseCase<Unit, NoParams> {
  final TodoTagRepository repository;
  SyncTodoTags(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await repository.syncTags();
  }
}
