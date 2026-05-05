import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';

class TodoItemRepositoryImpl implements TodoItemRepository {
  final TodoItemLocalDatasource localDataSource;
  final TodoItemRemoteDatasource remoteDataSource;
  final TodoTagLocalDatasource tagLocalDataSource;

  TodoItemRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.tagLocalDataSource,
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
  /// Returns 0 if not found — caller should handle this.
  Future<int> _resolveTaskListLocalId(String? remoteId) async {
    if (remoteId == null) return 0;
    // This lookup lives in the TodoList datasource — injected indirectly
    // by querying the tag local source pattern. Wire this via your DI layer.
    return 0;
  }

  @override
  Future<Either<Failure, TodoItemPage>> getTodoItems({
    String? url,
    String? taskListId,
    int? taskListLocalId,
  }) async {
    final remoteResult = await remoteDataSource.getTodoItems(
      url: url,
      taskListId: taskListId,
    );

    return remoteResult.fold(
      (failure) async {
        // Fallback to local cache, optionally filtered by list
        final localResult = await localDataSource.getTodoItems(
          taskListLocalId: taskListLocalId,
          isPendingDeletion: false,
        );
        return localResult.fold((l) => Left(l), (items) async {
          final entities = await Future.wait(
            items.map((item) async {
              final tags = await _resolveTags(item.localId);
              return item.toDomain(tags: tags);
            }),
          );
          return Right(TodoItemPage(items: entities));
        });
      },
      (paginatedDto) async {
        // Eagerly upsert remote data into local cache
        for (final dto in paginatedDto.results) {
          if (dto.id == null) continue;

          final existing = await localDataSource.getTodoItemByExternalID(
            dto.id!,
          );

          existing.fold((_) => null, (localModel) async {
            // Resolve remote task_list UUID to local ID
            int resolvedListLocalId = localModel?.taskListLocalId ?? 0;
            if (resolvedListLocalId == 0 && dto.taskList != null) {
              resolvedListLocalId = await _resolveTaskListLocalId(dto.taskList);
            }

            final dataModel = dto.toDataModel(
              localId: localModel?.localId ?? 0,
              taskListLocalId: resolvedListLocalId,
              isDirty: false,
            );

            if (localModel == null) {
              final created = await localDataSource.createTodoItem(dataModel);
              // Sync junction table tags
              created.fold((_) => null, (createdItem) async {
                final tagLocalIds = await _resolveTagUuidsToLocalIds(dto.tags);
                await localDataSource.syncTagsForTodoItem(
                  todoLocalId: createdItem.localId,
                  tagLocalIds: tagLocalIds,
                );
              });
            } else {
              await localDataSource.updateTodoItem(dataModel);
              final tagLocalIds = await _resolveTagUuidsToLocalIds(dto.tags);
              await localDataSource.syncTagsForTodoItem(
                todoLocalId: localModel.localId,
                tagLocalIds: tagLocalIds,
              );
            }
          });
        }

        final localResult = await localDataSource.getTodoItems(
          taskListLocalId: taskListLocalId,
          isPendingDeletion: false,
        );

        return localResult.fold((l) => Left(l), (items) async {
          final entities = await Future.wait(
            items.map((item) async {
              final tags = await _resolveTags(item.localId);
              return item.toDomain(tags: tags);
            }),
          );
          return Right(
            TodoItemPage(items: entities, nextUrl: paginatedDto.next),
          );
        });
      },
    );
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
          // Return stale local if remote fails
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
    // 1. Local-first
    final localResult = await localDataSource.createTodoItem(
      entity.toDataModel(),
    );

    return localResult.fold((failure) => Left(failure), (createdLocal) async {
      // Sync tags to junction table
      final tagLocalIds = entity.tags.map((t) => t.localId).toList();
      await localDataSource.syncTagsForTodoItem(
        todoLocalId: createdLocal.localId,
        tagLocalIds: tagLocalIds,
      );

      // 2. Sync to remote
      final remoteResult = await remoteDataSource.createTodoItem(
        createdLocal.toDto(),
      );

      return remoteResult.fold(
        (_) => Right(createdLocal.toDomain(tags: entity.tags)), // Offline
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
    // 1. Local-first
    final localResult = await localDataSource.updateTodoItem(
      entity.toDataModel(),
    );

    return localResult.fold((failure) => Left(failure), (updatedLocal) async {
      // Sync tags
      final tagLocalIds = entity.tags.map((t) => t.localId).toList();
      await localDataSource.syncTagsForTodoItem(
        todoLocalId: updatedLocal.localId,
        tagLocalIds: tagLocalIds,
      );

      // 2. Sync to remote
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

      // 1. Soft delete locally
      await localDataSource.softDeleteTodoItem(item);

      if (item.id == null) {
        // Never synced — hard delete immediately
        await localDataSource.hardDeleteTodoItem(item.localId);
        return const Right(unit);
      }

      // 2. Try remote delete
      final remoteResult = await remoteDataSource.deleteTodoItem(item.id!);

      return remoteResult.fold(
        (_) => const Right(unit), // Offline — sync will retry
        (_) async {
          await localDataSource.hardDeleteTodoItem(item.localId);
          return const Right(unit);
        },
      );
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

      // 1. Update status locally
      final updated = item.toCompanion(true);
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
        if (local.id == null) return Right(local.toDomain());

        // 2. Sync to remote
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

      // 1. Update status locally
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

      // 1. Update list locally
      final updatedItem = await localDataSource.updateTodoItem(
        TodoItem(
          localId: item.localId,
          id: item.id,
          taskListLocalId: targetListLocalId,
          title: item.title,
          notes: item.notes,
          status: item.status,
          priority: item.priority,
          due: item.due,
          completed: item.completed,
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
        // Need the remote task list UUID for the API call
        // This should be resolved via your DI / TodoList datasource
        if (local.id == null) return Right(local.toDomain());

        // Skipping remote move here — syncTodoItems() will handle it
        // via the update path since isDirty=true and taskListLocalId changed.
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
        // Case 1: Pending deletion
        if (item.isPendingDeletion) {
          if (item.id != null) await remoteDataSource.deleteTodoItem(item.id!);
          await localDataSource.hardDeleteTodoItem(item.localId);
          continue;
        }

        // Case 2: New or dirty
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
  Future<List<int>> _resolveTagUuidsToLocalIds(List<String> uuids) async {
    final localIds = <int>[];
    for (final uuid in uuids) {
      final result = await tagLocalDataSource.getTagByExternalID(uuid);
      result.fold((_) => null, (tag) {
        if (tag != null) localIds.add(tag.localId);
      });
    }
    return localIds;
  }
}
