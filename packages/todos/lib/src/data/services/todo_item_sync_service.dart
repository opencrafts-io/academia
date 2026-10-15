import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../datasource/todo_item_remote_datasource.dart';
import '../datasource/todo_local_store.dart';
import '../mappers/todo_item_mapper.dart';
import '../../domain/domain.dart';

class TodoItemSyncService {
  TodoItemSyncService(
    this._localDataSource,
    this._remoteDataSource,
    this._todoNotificationService,
  );

  final TodoLocalStore _localDataSource;
  final TodoItemRemoteDatasource _remoteDataSource;
  final TodoNotificationService _todoNotificationService;

  Future<Either<Failure, Unit>> sync() async {
    final dirtyResult = await _localDataSource.getTodoItems(isDirty: true);

    return dirtyResult.fold((failure) => Left(failure), (dirtyItems) async {
      for (final item in dirtyItems) {
        if (item.isPendingDeletion) {
          await _todoNotificationService.cancelReminder(item.localId);
          if (item.id?.isNotEmpty ?? false) {
            final deletion = await _remoteDataSource.deleteTodoItem(item.id!);
            if (deletion.isLeft()) continue;
          }
          final localDeletion = await _localDataSource.hardDeleteTodoItem(
            item.localId,
          );
          if (localDeletion.isLeft()) return localDeletion;
          continue;
        }

        final isNew = item.id == null || item.id!.isEmpty;
        final remoteOperation = isNew
            ? await _remoteDataSource.createTodoItem(item.toDto())
            : await _remoteDataSource.updateTodoItem(item.toDto());

        if (remoteOperation.isLeft()) continue;
        final dto = remoteOperation.fold((_) => null, (value) => value)!;
        // Re-read because a linked Pomodoro session may have incremented
        // focusedSeconds while the remote operation was in flight.
        final freshLocal = await _localDataSource.getTodoItemByID(item.localId);
        if (freshLocal.isLeft()) {
          return freshLocal.fold(
            (failure) => Left(failure),
            (_) => const Right(unit),
          );
        }
        final currentFocusedSeconds = freshLocal.fold(
          (_) => item.focusedSeconds,
          (fresh) => fresh?.focusedSeconds ?? item.focusedSeconds,
        );

        final localUpdate = await _localDataSource.updateTodoItem(
          dto.toDataModel(
            localId: item.localId,
            taskListLocalId: item.taskListLocalId,
            isDirty: false,
            focusedSeconds: currentFocusedSeconds,
          ),
        );
        if (localUpdate.isLeft()) {
          return localUpdate.fold(
            (failure) => Left(failure),
            (_) => const Right(unit),
          );
        }
      }
      return const Right(unit);
    });
  }
}
