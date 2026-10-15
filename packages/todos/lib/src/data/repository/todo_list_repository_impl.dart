import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:todos/src/data/data.dart';
import 'package:todos/src/domain/domain.dart';

@Injectable(as: TodoListRepository)
class TodoListRepositoryImpl implements TodoListRepository {
  final TodoLocalStore localDataSource;
  final TodoListRemoteDatasource remoteDataSource;

  TodoListRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, TodoPage>> getTodoLists({String? url}) async {
    final nextUrl = await _syncRemoteToLocal(url);
    final localResult = await localDataSource.getTodoLists();

    return localResult.fold(
      (failure) => Left(failure),
      (localModels) => Right(
        TodoPage(
          items: localModels.map((e) => e.toDomain()).toList(),
          nextUrl: nextUrl,
        ),
      ),
    );
  }

  Future<String?> _syncRemoteToLocal(String? url) async {
    final remoteResult = await remoteDataSource.getTodoLists(url: url);
    if (remoteResult.isLeft()) return null;

    final paginatedDto = remoteResult.getOrElse(
      () => throw StateError('missing response'),
    );
    await Future.wait(
      paginatedDto.results.map((dto) async {
        if (dto.id == null) return;
        final existing = await localDataSource.getTodoListByExternalID(dto.id!);

        await existing.fold((failure) async => null, (localModel) async {
          final dataModel = dto.toDataModel(
            localId: localModel?.localId ?? 0,
            isDirty: false,
          );

          if (localModel == null) {
            await localDataSource.createTodo(dataModel);
          } else {
            await localDataSource.updateTodoList(dataModel);
          }
        });
      }),
    );
    return paginatedDto.next;
  }

  @override
  Future<Either<Failure, TodoListEntity>> createTodoList(
    TodoListEntity entity,
  ) async {
    // 1. Local-First: Create immediately in DB
    final localResult = await localDataSource.createTodo(entity.toDataModel());

    return localResult.fold((failure) => Left(failure), (createdLocal) async {
      // 2. Sync to remote
      final remoteResult = await remoteDataSource.createTodoList(
        createdLocal.toDto(),
      );

      return remoteResult.fold(
        (failure) => Right(
          createdLocal.toDomain(),
        ), // Return success anyway (offline-first)
        (dto) async {
          // 3. Update local with server ID and clear dirty flag
          final synced = dto.toDataModel(
            localId: createdLocal.localId,
            isDirty: false,
          );
          await localDataSource.updateTodoList(synced);
          return Right(synced.toDomain());
        },
      );
    });
  }

  @override
  Future<Either<Failure, TodoListEntity>> updateTodoList(
    TodoListEntity entity,
  ) async {
    // 1. Local-First update
    final localResult = await localDataSource.updateTodoList(
      entity.toDataModel(),
    );

    return localResult.fold((failure) => Left(failure), (updatedLocal) async {
      // 2. Remote Sync
      final remoteResult = await remoteDataSource.updateTodoList(
        updatedLocal.toDto(),
      );

      return remoteResult.fold((failure) => Right(updatedLocal.toDomain()), (
        dto,
      ) async {
        // 3. Mark as clean on success
        final synced = dto.toDataModel(
          localId: updatedLocal.localId,
          isDirty: false,
        );
        await localDataSource.updateTodoList(synced);
        return Right(synced.toDomain());
      });
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteTodoList(int todoListLocalId) async {
    final localItem = await localDataSource.getTodoByID(todoListLocalId);

    return localItem.fold((failure) => Left(failure), (item) async {
      if (item == null) return const Right(unit);

      // 1. Soft delete (mark for deletion)
      await localDataSource.softDeleteTodoList(item);

      // 2. Try remote delete
      final remoteResult = await remoteDataSource.deleteTodoList(item.id ?? '');

      return remoteResult.fold(
        (failure) =>
            const Right(unit), // Still success, background sync will try again
        (_) async {
          // 3. If remote success, hard delete from local
          await localDataSource.hardDeleteTodoList(item.localId);
          return const Right(unit);
        },
      );
    });
  }

  @override
  Future<Either<Failure, TodoListEntity>> getTodoListById(String id) async {
    // Check local first
    final localResult = await localDataSource.getTodoListByExternalID(id);

    return localResult.fold((failure) => Left(failure), (localItem) async {
      if (localItem != null && !localItem.isDirty) {
        return Right(localItem.toDomain());
      }
      // Fetch fresh if dirty or missing
      final remoteResult = await remoteDataSource.getTodoListById(id);
      return remoteResult.map((dto) => dto.toEntity());
    });
  }

  @override
  Future<Either<Failure, TodoListEntity>> markTodoListModified(
    int todoListLocalId,
  ) async {
    final existingResult = await localDataSource.getTodoByID(todoListLocalId);

    return existingResult.fold((failure) => Left(failure), (existing) async {
      if (existing == null) {
        return Left(
          CacheFailure(
            message: "No TodoList found with ID $todoListLocalId",
            error: Exception("TodoList not found"),
          ),
        );
      }

      final touched = existing.copyWith(updatedAt: DateTime.now());
      final result = await localDataSource.updateTodoList(touched);
      return result.fold(
        (failure) => Left(failure),
        (updated) => Right(updated.toDomain()),
      );
    });
  }

  @override
  Future<Either<Failure, TodoListEntity>> getDefaultTodoList() async {
    final result = await remoteDataSource.fetchDefaultTodoList();
    return result.map((dto) => dto.toEntity());
  }

  @override
  Future<Either<Failure, Unit>> syncTodoLists() async {
    // 1. Get all dirty items (modified or newly created)
    final dirtyItemsResult = await localDataSource.getTodoLists(isDirty: true);

    return dirtyItemsResult.fold((l) => Left(l), (dirtyItems) async {
      for (final item in dirtyItems) {
        // Case 1: Pending Deletion
        if (item.isPendingDeletion) {
          if (item.id?.isNotEmpty ?? false) {
            final deletion = await remoteDataSource.deleteTodoList(item.id!);
            if (deletion.isLeft()) continue;
          }
          final localDeletion = await localDataSource.hardDeleteTodoList(
            item.localId,
          );
          if (localDeletion.isLeft()) return localDeletion;
          continue;
        }

        // Case 2: Needs creation or update on remote
        final isNew = item.id == null || item.id!.isEmpty;
        final remoteOp = isNew
            ? await remoteDataSource.createTodoList(item.toDto())
            : await remoteDataSource.updateTodoList(item.toDto());

        if (remoteOp.isLeft()) continue;
        final dto = remoteOp.fold((_) => null, (value) => value)!;
        final localUpdate = await localDataSource.updateTodoList(
          dto.toDataModel(localId: item.localId, isDirty: false),
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
