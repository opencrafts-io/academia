import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/todos/data/dtos/paginated_todo_item_dto.dart';
import 'package:dartz/dartz.dart';

class TodoItemRepositoryImpl implements TodoItemRepository {
  final TodoItemLocalDatasource localDataSource;
  final TodoItemRemoteDatasource remoteDataSource;
  final TodoTagLocalDatasource tagLocalDataSource;
  final TodoListLocalDatasource listLocalDataSource;
  final TodoNotificationService todoNotificationService;

  TodoItemRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.tagLocalDataSource,
    required this.listLocalDataSource,
    required this.todoNotificationService,
  });

  /// Resolves tags for a [TodoItem] from local DB via the junction table.
  Future<List<TodoTagEntity>> _resolveTags(int todoLocalId) async {
    final result = await localDataSource.getTagsForTodoItem(todoLocalId);
    return result.fold(
      (_) => [],
      (tags) => tags.map((t) => t.toDomain()).toList(),
    );
  }

  /// Resolves a remote task list UUID to a local ID.
  /// Creates a "ghost" placeholder if not found.
  Future<int> _resolveTaskListLocalId(String? remoteId) async {
    if (remoteId == null) return 0;

    final existing = await listLocalDataSource.getTodoListByExternalID(
      remoteId,
    );

    return await existing.fold((_) => 0, (list) async {
      if (list != null) return list.localId;

      // Create a Ghost list placeholder
      final ghost = TodoList(
        localId: 0,
        id: remoteId,
        title: "Loading list...",
        isDirty: false, // Don't sync stubs back to server
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isPendingDeletion: false,
        isDefault: false,
        taskCount: 0,
        syncStatus: SyncStatus.pending,
      );

      final created = await listLocalDataSource.createTodo(ghost);
      return created.fold((_) => 0, (l) => l.localId);
    });
  }

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

    final localResult = results[0] as Either<Failure, List<TodoItem>>;
    final remoteResult = results[1] as Either<Failure, PaginatedTodoItemDto>;

    final localEntities = await localResult.fold(
      (_) => Future.value(<TodoItemEntity>[]),
      (items) => Future.wait(
        items.map((item) async {
          final tags = await _resolveTags(item.localId);
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
            resolvedListLocalId = await _resolveTaskListLocalId(dto.taskList);
          }

          final dataModel = dto.toDataModel(
            localId: localModel?.localId ?? 0,
            taskListLocalId: resolvedListLocalId,
            isDirty: false,
          );

          if (localModel != null) {
            await Future.wait([
              localDataSource.updateTodoItem(dataModel),
              _resolveTagUuidsToLocalIds(dto.tags).then(
                (tagLocalIds) => localDataSource.syncTagsForTodoItem(
                  todoLocalId: localModel.localId,
                  tagLocalIds: tagLocalIds,
                ),
              ),
            ]);
          } else {
            final created = await localDataSource.createTodoItem(dataModel);
            await created.fold((_) => Future.value(), (createdItem) async {
              final tagLocalIds = await _resolveTagUuidsToLocalIds(dto.tags);
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
          final tags = await _resolveTags(item.localId);
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
        final tags = await _resolveTags(localItem.localId);
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
          final resolvedListLocalId = await _resolveTaskListLocalId(
            dto.taskList,
          );
          final dataModel = dto.toDataModel(
            localId: localItem?.localId ?? 0,
            taskListLocalId: resolvedListLocalId,
            isDirty: false,
          );
          if (localItem == null) {
            await localDataSource.createTodoItem(dataModel);
          } else {
            await localDataSource.updateTodoItem(dataModel);
          }
          final tagLocalIds = await _resolveTagUuidsToLocalIds(dto.tags);
          await localDataSource.syncTagsForTodoItem(
            todoLocalId: dataModel.localId,
            tagLocalIds: tagLocalIds,
          );
          final tags = await _resolveTags(dataModel.localId);
          return Right(dataModel.toDomain(tags: tags));
        },
      );
    });
  }

  @override
  Future<Either<Failure, TodoItemEntity>> createTodoItem(
    TodoItemEntity entity,
  ) async {
    final taskListRes = await listLocalDataSource.getTodoByID(
      entity.taskListLocalId,
    );
    if (taskListRes.isLeft()) {
      return Left(
        NoDataFoundFailure(
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

      final taskList = (taskListRes as Right).value as TodoList;

      final remoteResult = await remoteDataSource.createTodoItem(
        createdLocal.toDto().copyWith(taskList: taskList.id),
      );

      return remoteResult.fold(
        (failure) => Right(createdLocal.toDomain(tags: entity.tags)),
        (dto) async {
          final resolvedListLocalId = await _resolveTaskListLocalId(
            dto.taskList,
          );
          final synced = dto.toDataModel(
            localId: createdLocal.localId,
            taskListLocalId: resolvedListLocalId != 0
                ? resolvedListLocalId
                : entity.taskListLocalId,
            isDirty: false,
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
          final synced = dto.toDataModel(
            localId: updatedLocal.localId,
            taskListLocalId: entity.taskListLocalId,
            isDirty: false,
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
        TodoItem(
          localId: item.localId,
          id: item.id,
          taskListLocalId: item.taskListLocalId,
          title: item.title,
          notes: item.notes,
          status: TodoStatus.completed,
          priority: item.priority,
          due: item.due,
          completed: DateTime.now(),
          subtaskCount: item.subtaskCount,
          position: item.position,
          hidden: item.hidden,
          syncStatus: item.syncStatus,
          lastSyncedAt: item.lastSyncedAt,
          createdAt: item.createdAt,
          updatedAt: DateTime.now(),
          isPendingDeletion: item.isPendingDeletion,
          isDirty: true,
        ),
      );

      return updatedItem.fold((failure) => Left(failure), (local) async {
        todoNotificationService.cancelReminder(local.localId);
        if (local.id == null) return Right(local.toDomain());

        final remoteResult = await remoteDataSource.completeTodoItem(
          local.id!,
          local.toDto(),
        );

        return remoteResult.fold((_) => Right(local.toDomain()), (dto) async {
          final synced = dto.toDataModel(
            localId: local.localId,
            taskListLocalId: local.taskListLocalId,
            isDirty: false,
          );
          await localDataSource.updateTodoItem(synced);
          final tags = await _resolveTags(synced.localId);
          return Right(synced.toDomain(tags: tags));
        });
      });
    });
  }

  @override
  Future<Either<Failure, TodoItemEntity>> reopenTodoItem(int localId) async {
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
        TodoItem(
          localId: item.localId,
          id: item.id,
          taskListLocalId: item.taskListLocalId,
          title: item.title,
          notes: item.notes,
          status: TodoStatus.needsAction,
          priority: item.priority,
          due: item.due,
          completed: null,
          subtaskCount: item.subtaskCount,
          position: item.position,
          hidden: item.hidden,
          syncStatus: item.syncStatus,
          lastSyncedAt: item.lastSyncedAt,
          createdAt: item.createdAt,
          updatedAt: DateTime.now(),
          isPendingDeletion: item.isPendingDeletion,
          isDirty: true,
        ),
      );

      return updatedItem.fold((failure) => Left(failure), (local) async {
        if (local.due != null) {
          todoNotificationService.scheduleReminder(local.toDomain());
        }
        if (local.id == null) return Right(local.toDomain());

        final remoteResult = await remoteDataSource.reopenTodoItem(
          local.id!,
          local.toDto(),
        );

        return remoteResult.fold((_) => Right(local.toDomain()), (dto) async {
          final synced = dto.toDataModel(
            localId: local.localId,
            taskListLocalId: local.taskListLocalId,
            isDirty: false,
          );
          await localDataSource.updateTodoItem(synced);
          final tags = await _resolveTags(synced.localId);
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

      final taskListRes = await listLocalDataSource.getTodoByID(
        targetListLocalId,
      );
      if (taskListRes.isLeft()) {
        return Left(
          NoDataFoundFailure(
            message: "Invalid tasklist!",
            error: (taskListRes as Left),
          ),
        );
      }

      final taskList = (taskListRes as Right).value as TodoList;

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
        final tags = await _resolveTags(local.localId);
        return Right(local.toDomain(tags: tags));
      });
    });
  }

  @override
  Future<Either<Failure, Unit>> syncTodoItems() async {
    final dirtyResult = await localDataSource.getTodoItems(isDirty: true);

    return dirtyResult.fold((l) => Left(l), (dirtyItems) async {
      for (final item in dirtyItems) {
        if (item.isPendingDeletion) {
          todoNotificationService.cancelReminder(item.localId);
          if (item.id != null) await remoteDataSource.deleteTodoItem(item.id!);
          await localDataSource.hardDeleteTodoItem(item.localId);
          continue;
        }

        final isNew = item.id == null || item.id!.isEmpty;
        final remoteOp = isNew
            ? await remoteDataSource.createTodoItem(item.toDto())
            : await remoteDataSource.updateTodoItem(item.toDto());

        remoteOp.fold((_) => null, (dto) async {
          await localDataSource.updateTodoItem(
            dto.toDataModel(
              localId: item.localId,
              taskListLocalId: item.taskListLocalId,
              isDirty: false,
            ),
          );
        });
      }
      return const Right(unit);
    });
  }

  /// Resolves a list of remote tag UUIDs to their local IDs.
  /// Creates ghost tags if they don't exist.
  Future<List<int>> _resolveTagUuidsToLocalIds(List<String> uuids) async {
    final localIds = <int>[];
    for (final uuid in uuids) {
      final result = await tagLocalDataSource.getTagByExternalID(uuid);
      await result.fold((_) async => null, (tag) async {
        if (tag != null) {
          localIds.add(tag.localId);
        } else {
          // Create ghost tag
          final ghost = TodoTagItem(
            localId: 0,
            id: uuid,
            name: "Loading tag...",
            isDirty: false,
            createdAt: DateTime.now(),
            isPendingDeletion: false,
            syncStatus: SyncStatus.pending,
          );
          final created = await tagLocalDataSource.createTag(ghost);
          created.fold((_) => null, (t) => localIds.add(t.localId));
        }
      });
    }
    return localIds;
  }
}
