import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../datasource/todo_item_remote_datasource.dart';
import '../datasource/todo_local_store.dart';
import '../mappers/todo_item_mapper.dart';
import '../../domain/domain.dart';

class TodoItemSyncService {
  TodoItemSyncService({
    required TodoLocalStore localDataSource,
    required TodoItemRemoteDatasource remoteDataSource,
    required TodoNotificationService todoNotificationService,
  }) : _localDataSource = localDataSource,
       _remoteDataSource = remoteDataSource,
       _todoNotificationService = todoNotificationService;

  final TodoLocalStore _localDataSource;
  final TodoItemRemoteDatasource _remoteDataSource;
  final TodoNotificationService _todoNotificationService;

  Future<Either<Failure, Unit>> sync() async {
    final dirtyResult = await _localDataSource.getTodoItems(isDirty: true);

    return dirtyResult.fold((failure) => Left(failure), (dirtyItems) async {
      for (final item in dirtyItems) {
        if (item.isPendingDeletion) {
          _todoNotificationService.cancelReminder(item.localId);
          if (item.id != null) {
            await _remoteDataSource.deleteTodoItem(item.id!);
          }
          await _localDataSource.hardDeleteTodoItem(item.localId);
          continue;
        }

        final isNew = item.id == null || item.id!.isEmpty;
        final remoteOperation = isNew
            ? await _remoteDataSource.createTodoItem(item.toDto())
            : await _remoteDataSource.updateTodoItem(item.toDto());

        remoteOperation.fold((_) => null, (dto) async {
          // Re-read because a linked Pomodoro session may have incremented
          // focusedSeconds while the remote operation was in flight.
          final freshLocal = await _localDataSource.getTodoItemByID(
            item.localId,
          );
          final currentFocusedSeconds = freshLocal.fold(
            (_) => item.focusedSeconds,
            (fresh) => fresh?.focusedSeconds ?? item.focusedSeconds,
          );

          await _localDataSource.updateTodoItem(
            dto.toDataModel(
              localId: item.localId,
              taskListLocalId: item.taskListLocalId,
              isDirty: false,
              focusedSeconds: currentFocusedSeconds,
            ),
          );
        });
      }
      return const Right(unit);
    });
  }
}
