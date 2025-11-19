import 'package:academia/core/core.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:dartz/dartz.dart';

class SyncTodosWithGoogleTasksUsecase extends UseCase<bool, NoParams> {
  final TodoRepository todoRepository;

  SyncTodosWithGoogleTasksUsecase({required this.todoRepository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await todoRepository.syncWithGoogleTasks();
  }
}
