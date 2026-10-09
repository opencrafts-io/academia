import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:todos/src/data/data.dart';
import 'package:todos/src/domain/domain.dart';

@Injectable(as: TodoItemRepository)
class TodoItemRepositoryImpl implements TodoItemRepository {
  final TodoLocalStore localDataSource;
  final TodoItemRemoteDatasource remoteDataSource;
  final TodoNotificationService todoNotificationService;

  TodoItemRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.todoNotificationService,
  }) : _tagResolver = TodoItemTagResolver(localDataSource);

  final TodoItemTagResolver _tagResolver;
  late final TodoItemSyncService _syncService = TodoItemSyncService(
    localDataSource: localDataSource,
    remoteDataSource: remoteDataSource,
    todoNotificationService: todoNotificationService,
  );

  @override
  Future<Either<Failure, TodoItemPage>> getTodoItems({
    String? url,
    String? taskListId,
    int? taskListLocalId,
  }) async {
    final results = await Future.wait([
      localDataSource.getTodoItems(
        taskListLocalId: taskListLocalId,
        isPendingDeletion: false,
      ),
      remoteDataSource.getTodoItems(url: url, taskListId: taskListId),
    ]);

    final localResult = results[0] as Either<Failure, List<TodoItemEntity>>;
    final remoteResult = results[1] as Either<Failure, PaginatedTodoItemDto>;

    final localEntities = await localResult.fold(
      (_) => Future.value(<TodoItemEntity>[]),
      (items) => Future.wait(
        items.map((item) async {
          final tags = await _tagResolver.resolveTags(item.localId);
          return item.toDomain(tags: tags);
        }),
      ),
    );

    if (remoteResult.isLeft()) {
      return localResult.fold(
        (failure) => Left(failure),
        (_) => Right(TodoItemPage(items: localEntities)),
      );
    }

    final paginatedDto = remoteResult.getOrElse(() => throw Exception());

    await Future.wait(
      paginatedDto.results.where((dto) => dto.id != null).map((dto) async {
        final existing = await localDataSource.getTodoItemByExternalID(dto.id!);

        await existing.fold((_) => Future.value(), (localModel) async {
          int resolvedListLocalId = localModel?.taskListLocalId ?? 0;
          if (resolvedListLocalId == 0 || dto.taskList != null) {
            resolvedListLocalId = await _tagResolver.resolveTaskListLocalId(
              dto.taskList,
            );
          }

          final dataModel = dto.toDataModel(
            localId: localModel?.localId ?? 0,
            taskListLocalId: resolvedListLocalId,
            isDirty: false,
            focusedSeconds: localModel?.focusedSeconds ?? 0,
          );

          if (localModel != null) {
            await Future.wait([
              localDataSource.updateTodoItem(dataModel),
              _tagResolver.resolveTagUuidsToLocalIds(dto.tags).then(
                (tagLocalIds) => localDataSource.syncTagsForTodoItem(
                  todoLocalId: localModel.localId,
                  tagLocalIds: tagLocalIds,
                ),
              ),
            ]);
          } else {
            final created = await localDataSource.createTodoItem(dataModel);
            await created.fold((_) => Future.value(), (createdItem) async {
              final tagLocalIds = await _tagResolver.resolveTagUuidsToLocalIds(
                dto.tags,
              );
              await localDataSource.syncTagsForTodoItem(
                todoLocalId: createdItem.localId,
                tagLocalIds: tagLocalIds,
              );
            });
          }
        });
      }),
    );

    final freshLocal = await localDataSource.getTodoItems(
      taskListLocalId: taskListLocalId,
      isPendingDeletion: false,
    );

    return freshLocal.fold((_) => Right(TodoItemPage(items: localEntities)), (
      items,
    ) async {
      final entities = await Future.wait(
        items.map((item) async {
          final tags = await _tagResolver.resolveTags(item.localId);
          return item.toDomain(tags: tags);
        }),
      );
      return Right(TodoItemPage(items: entities, nextUrl: paginatedDto.next));
    });
  }

  @override
  Future<Either<Failure, TodoItemEntity>> getTodoItemById(String id) async {
    final localResult = await localDataSource.getTodoItemByExternalID(id);

    return localResult.fold((failure) => Left(failure), (localItem) async {
      if (localItem != null && !localItem.isDirty) {
        final tags = await _tagResolver.resolveTags(localItem.localId);
        return Right(localItem.toDomain(tags: tags));
      }

      final remoteResult = await remoteDataSource.getTodoItemById(id);
      return remoteResult.fold(
        (failure) {
          if (localItem != null) {
            return Right(localItem.toDomain());
          }
          return Left(failure);
        },
        (dto) async {
          final resolvedListLocalId = await _tagResolver.resolveTaskListLocalId(
            dto.taskList,
          );
          final dataModel = dto.toDataModel(
            localId: localItem?.localId ?? 0,
            taskListLocalId: resolvedListLocalId,
            isDirty: false,
            focusedSeconds: localItem?.focusedSeconds ?? 0,
          );
          if (localItem == null) {
            await localDataSource.createTodoItem(dataModel);
          } else {
            await localDataSource.updateTodoItem(dataModel);
          }
          final tagLocalIds = await _tagResolver.resolveTagUuidsToLocalIds(
            dto.tags,
          );
          await localDataSource.syncTagsForTodoItem(
            todoLocalId: dataModel.localId,
            tagLocalIds: tagLocalIds,
          );
          final tags = await _tagResolver.resolveTags(dataModel.localId);
          return Right(dataModel.toDomain(tags: tags));
        },
      );
    });
  }

  @override
  Future<Either<Failure, TodoItemEntity>> createTodoItem(
    TodoItemEntity entity,
  ) async {
    final taskListRes = await localDataSource.getTodoByID(
      entity.taskListLocalId,
    );
    if (taskListRes.isLeft()) {
      return Left(
        Failure.validation(
          message: "Invalid tasklist!",
          error: (taskListRes as Left),
        ),
      );
    }

    final localResult = await localDataSource.createTodoItem(
      entity.toDataModel(),
    );

    return localResult.fold((failure) => Left(failure), (createdLocal) async {
      final tagLocalIds = entity.tags.map((t) => t.localId).toList();
      await localDataSource.syncTagsForTodoItem(
        todoLocalId: createdLocal.localId,
        tagLocalIds: tagLocalIds,
      );

      if (entity.due != null) {
        todoNotificationService.scheduleReminder(
          createdLocal.toDomain(tags: entity.tags),
        );
      }

      final taskList = (taskListRes as Right).value as TodoListEntity;

      final remoteResult = await remoteDataSource.createTodoItem(
        createdLocal.toDto().copyWith(taskList: taskList.id),
      );

      return remoteResult.fold(
        (failure) => Right(createdLocal.toDomain(tags: entity.tags)),
        (dto) async {
          final resolvedListLocalId = await _tagResolver.resolveTaskListLocalId(
            dto.taskList,
          );
          final synced = dto.toDataModel(
            localId: createdLocal.localId,
            taskListLocalId: resolvedListLocalId != 0
                ? resolvedListLocalId
                : entity.taskListLocalId,
            isDirty: false,
            focusedSeconds: createdLocal.focusedSeconds,
          );
          await localDataSource.updateTodoItem(synced);
          return Right(synced.toDomain(tags: entity.tags));
        },
      );
    });
  }

  @override
  Future<Either<Failure, TodoItemEntity>> updateTodoItem(
    TodoItemEntity entity,
  ) async {
    final localResult = await localDataSource.updateTodoItem(
      entity.toDataModel(),
    );

    return localResult.fold((failure) => Left(failure), (updatedLocal) async {
      final tagLocalIds = entity.tags.map((t) => t.localId).toList();
      await localDataSource.syncTagsForTodoItem(
        todoLocalId: updatedLocal.localId,
        tagLocalIds: tagLocalIds,
      );

      if (entity.due != null) {
        todoNotificationService.rescheduleReminder(
          updatedLocal.toDomain(tags: entity.tags),
        );
      } else {
        todoNotificationService.cancelReminder(entity.localId);
      }

      final remoteResult = await remoteDataSource.updateTodoItem(
        updatedLocal.toDto(),
      );

      return remoteResult.fold(
        (_) => Right(updatedLocal.toDomain(tags: entity.tags)),
        (dto) async {
          // Re-read the current local row rather than reusing the
          // pre-await `updatedLocal` snapshot — a linked Pomodoro session
          // may have incremented focusedSeconds while this remote call
          // was in flight, and writing back the stale value would
          // silently discard that tracked time.
          final freshLocal = await localDataSource.getTodoItemByID(
            updatedLocal.localId,
          );
          final currentFocusedSeconds = freshLocal.fold(
            (_) => updatedLocal.focusedSeconds,
            (fresh) => fresh?.focusedSeconds ?? updatedLocal.focusedSeconds,
          );

          final synced = dto.toDataModel(
            localId: updatedLocal.localId,
            taskListLocalId: entity.taskListLocalId,
            isDirty: false,
            focusedSeconds: currentFocusedSeconds,
          );
          await localDataSource.updateTodoItem(synced);
          return Right(synced.toDomain(tags: entity.tags));
        },
      );
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteTodoItem(int localId) async {
    final localItem = await localDataSource.getTodoItemByID(localId);

    return localItem.fold((failure) => Left(failure), (item) async {
      if (item == null) return const Right(unit);

      await localDataSource.softDeleteTodoItem(item);
      todoNotificationService.cancelReminder(item.localId);

      if (item.id == null) {
        await localDataSource.hardDeleteTodoItem(item.localId);
        todoNotificationService.notifyDeleted(item.toDomain());
        return const Right(unit);
      }

      final remoteResult = await remoteDataSource.deleteTodoItem(item.id!);

      return remoteResult.fold((_) => const Right(unit), (_) async {
        await localDataSource.hardDeleteTodoItem(item.localId);
        todoNotificationService.notifyDeleted(item.toDomain());
        return const Right(unit);
      });
    });
  }

  @override
  Future<Either<Failure, TodoItemEntity>> completeTodoItem(int localId) async {
    return _updateCompletionState(
      localId,
      status: TodoStatus.completed,
      completed: DateTime.now(),
      remoteUpdate: (local) => remoteDataSource.completeTodoItem(
        local.id!,
        local.toDto(),
      ),
    );
  }

  @override
  Future<Either<Failure, TodoItemEntity>> reopenTodoItem(int localId) async {
    return _updateCompletionState(
      localId,
      status: TodoStatus.needsAction,
      completed: null,
      remoteUpdate: (local) => remoteDataSource.reopenTodoItem(
        local.id!,
        local.toDto(),
      ),
    );
  }

  Future<Either<Failure, TodoItemEntity>> _updateCompletionState(
    int localId, {
    required TodoStatus status,
    required DateTime? completed,
    required Future<Either<Failure, TodoItemDto>> Function(TodoItemEntity local)
    remoteUpdate,
  }) async {
    final localItem = await localDataSource.getTodoItemByID(localId);

    return localItem.fold((failure) => Left(failure), (item) async {
      if (item == null) {
        return Left(
          CacheFailure(
            message: "Task not found",
            error: Exception("No item with localId $localId"),
          ),
        );
      }

      final updatedItem = await localDataSource.updateTodoItem(
        item.copyWith(
          status: status,
          completed: completed,
          updatedAt: DateTime.now(),
          isDirty: true,
        ),
      );

      return updatedItem.fold((failure) => Left(failure), (local) async {
        if (status == TodoStatus.completed) {
          todoNotificationService.cancelReminder(local.localId);
        } else if (local.due != null) {
          todoNotificationService.scheduleReminder(local.toDomain());
        }
        if (local.id == null) return Right(local.toDomain());

        final remoteResult = await remoteUpdate(local);

        return remoteResult.fold((_) => Right(local.toDomain()), (dto) async {
          final synced = dto.toDataModel(
            localId: local.localId,
            taskListLocalId: local.taskListLocalId,
            isDirty: false,
            focusedSeconds: local.focusedSeconds,
          );
          await localDataSource.updateTodoItem(synced);
          final tags = await _tagResolver.resolveTags(synced.localId);
          return Right(synced.toDomain(tags: tags));
        });
      });
    });
  }

  @override
  Future<Either<Failure, TodoItemEntity>> moveTodoItem({
    required int localId,
    required int targetListLocalId,
  }) async {
    final localItem = await localDataSource.getTodoItemByID(localId);

    return localItem.fold((failure) => Left(failure), (item) async {
      if (item == null) {
        return Left(
          CacheFailure(
            message: "Task not found",
            error: Exception("No item with localId $localId"),
          ),
        );
      }

      final taskListRes = await localDataSource.getTodoByID(targetListLocalId);
      if (taskListRes.isLeft()) {
        return Left(
          Failure.validation(
            message: "Invalid tasklist!",
            error: (taskListRes as Left),
          ),
        );
      }

      final taskList = (taskListRes as Right).value as TodoListEntity;

      final (remoteRes, updatedItem) = await (
        remoteDataSource.moveTodoItem(
          taskId: item.id ?? '',
          taskListId: taskList.id ?? '',
        ),
        localDataSource.updateTodoItem(
          item.copyWith(taskListLocalId: targetListLocalId, isDirty: true),
        ),
      ).wait;

      return updatedItem.fold((failure) => Left(failure), (local) async {
        if (local.id == null) return Right(local.toDomain());
        final tags = await _tagResolver.resolveTags(local.localId);
        return Right(local.toDomain(tags: tags));
      });
    });
  }

  @override
  Future<Either<Failure, Unit>> syncTodoItems() => _syncService.sync();

  @override
  Future<Either<Failure, TodoItemEntity>> addFocusedTime({
    required int todoLocalId,
    required Duration duration,
  }) async {
    final result = await localDataSource.addFocusedTime(todoLocalId, duration);

    return result.fold((failure) => Left(failure), (updated) async {
      final tags = await _tagResolver.resolveTags(updated.localId);
      return Right(updated.toDomain(tags: tags));
    });
  }

}
