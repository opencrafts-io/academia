import 'package:academia/core/core.dart';
import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';

class TodoListRepositoryImpl implements TodoListRepository {
  final TodoListLocalDatasource localDataSource;
  final TodoListRemoteDatasource remoteDataSource;

  TodoListRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, TodoPage>> getTodoLists({String? url}) async {
    // 1. Fetch from remote
    final remoteResult = await remoteDataSource.getTodoLists(url: url);

    return remoteResult.fold(
      (failure) async {
        // Fallback to local if remote fails
        final localResult = await localDataSource.getTodoLists();
        return localResult.fold(
          (l) => Left(l),
          (r) => Right(TodoPage(items: r.map((e) => e.toDomain()).toList())),
        );
      },
      (paginatedDto) async {
        // 2. Eagerly update local cache with fresh server data
        for (var dto in paginatedDto.results) {
          final existing = await localDataSource.getTodoListByExternalID(
            dto.id!,
          );

          existing.fold(
            (failure) => null,
            // Ignore errors for individual item checks
            (localModel) async {
              final dataModel = dto.toDataModel(
                localId: localModel?.localId ?? 0,
                isDirty: false, // Server data is clean
              );

              if (localModel == null) {
                await localDataSource.createTodo(dataModel);
              } else {
                // Using a 'clean' update here would be ideal, but for now we update
                await localDataSource.updateTodoList(dataModel);
              }
            },
          );
        }

        final localResult = await localDataSource.getTodoLists();
        return localResult.fold(
          (l) => Left(l),
          (r) => Right(
            TodoPage(
              items: r.map((e) => e.toDomain()).toList(),
              nextUrl: paginatedDto.next,
            ),
          ),
        );
      },
    );
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
          if (item.id != null) await remoteDataSource.deleteTodoList(item.id!);
          await localDataSource.hardDeleteTodoList(item.localId);
          continue;
        }

        // Case 2: Needs creation or update on remote
        final isNew = item.id == null || item.id!.isEmpty;
        final remoteOp = isNew
            ? await remoteDataSource.createTodoList(item.toDto())
            : await remoteDataSource.updateTodoList(item.toDto());

        remoteOp.fold(
          (failure) => null, // Log and continue
          (dto) async {
            // Mark as clean and update with potential server-side changes
            await localDataSource.updateTodoList(
              dto.toDataModel(localId: item.localId, isDirty: false),
            );
          },
        );
      }
      return const Right(unit);
    });
  }
}
