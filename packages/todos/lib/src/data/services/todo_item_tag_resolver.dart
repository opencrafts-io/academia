import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:todos/src/data/datasource/todo_local_store.dart';
import 'package:todos/src/domain/domain.dart';

class TodoItemTagResolver {
  TodoItemTagResolver(this._localDataSource);

  final TodoLocalStore _localDataSource;

  Future<List<TodoTagEntity>> resolveTags(int todoLocalId) async {
    final result = await _localDataSource.getTagsForTodoItem(todoLocalId);
    return result.fold((_) => [], (tags) => tags);
  }

  Future<int> resolveTaskListLocalId(String? remoteId) async {
    final result = await resolveTaskListLocalIdResult(remoteId);
    return result.fold((_) => 0, (id) => id);
  }

  Future<Either<Failure, int>> resolveTaskListLocalIdResult(
    String? remoteId,
  ) async {
    if (remoteId == null) return const Right(0);

    final existing = await _localDataSource.getTodoListByExternalID(remoteId);

    return existing.fold((failure) => Left(failure), (list) async {
      if (list != null) return Right(list.localId);

      final ghost = TodoListEntity(
        localId: 0,
        id: remoteId,
        title: 'Loading list...',
        isDirty: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isPendingDeletion: false,
        isDefault: false,
        taskCount: 0,
        syncStatus: SyncStatus.pending,
      );

      final created = await _localDataSource.createTodo(ghost);
      return created.map((list) => list.localId);
    });
  }

  Future<Either<Failure, List<int>>> resolveTagUuidsToLocalIds(
    List<String> uuids,
  ) async {
    final localIds = <int>[];
    for (final uuid in uuids) {
      final result = await _localDataSource.getTagByExternalID(uuid);
      final lookupFailure = result.fold<Failure?>(
        (failure) => failure,
        (_) => null,
      );
      if (lookupFailure != null) return Left(lookupFailure);
      final tag = result.fold((_) => null, (value) => value);
      if (tag != null) {
        localIds.add(tag.localId);
      } else {
        final ghost = TodoTagEntity(
          localId: 0,
          id: uuid,
          name: 'Loading tag...',
          isDirty: false,
          createdAt: DateTime.now(),
          isPendingDeletion: false,
          syncStatus: SyncStatus.pending,
        );
        final created = await _localDataSource.createTag(ghost);
        final createFailure = created.fold<Failure?>(
          (failure) => failure,
          (_) => null,
        );
        if (createFailure != null) return Left(createFailure);
        created.fold((_) {}, (createdTag) => localIds.add(createdTag.localId));
      }
    }
    return Right(localIds);
  }
}
