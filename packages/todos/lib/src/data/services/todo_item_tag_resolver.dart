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
    if (remoteId == null) return 0;

    final existing = await _localDataSource.getTodoListByExternalID(remoteId);

    return existing.fold((_) => 0, (list) async {
      if (list != null) return list.localId;

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
      return created.fold((_) => 0, (list) => list.localId);
    });
  }

  Future<List<int>> resolveTagUuidsToLocalIds(List<String> uuids) async {
    final localIds = <int>[];
    for (final uuid in uuids) {
      final result = await _localDataSource.getTagByExternalID(uuid);
      await result.fold((_) async => null, (tag) async {
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
          created.fold((_) => null, (tag) => localIds.add(tag.localId));
        }
      });
    }
    return localIds;
  }
}
