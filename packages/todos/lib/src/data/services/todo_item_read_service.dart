import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../datasource/todo_item_remote_datasource.dart';
import '../datasource/todo_local_store.dart';
import '../dtos/todo_item_dto.dart';
import '../mappers/todo_item_mapper.dart';
import '../../domain/domain.dart';
import 'todo_item_tag_resolver.dart';

class TodoItemReadService {
  TodoItemReadService(this._localDataSource, this._remoteDataSource)
    : _tagResolver = TodoItemTagResolver(_localDataSource);

  final TodoLocalStore _localDataSource;
  final TodoItemRemoteDatasource _remoteDataSource;
  final TodoItemTagResolver _tagResolver;

  Future<Either<Failure, TodoItemPage>> getTodoItems({
    String? url,
    String? taskListId,
    int? taskListLocalId,
  }) async {
    final localRequest = _localDataSource.getTodoItems(
      taskListLocalId: taskListLocalId,
      isPendingDeletion: false,
    );
    final remoteRequest = _remoteDataSource.getTodoItems(
      url: url,
      taskListId: taskListId,
    );
    final localResult = await localRequest;
    final remoteResult = await remoteRequest;

    if (remoteResult.isLeft()) return _pageFromLocal(localResult);

    final page = remoteResult.fold((_) => null, (value) => value)!;
    for (final dto in page.results) {
      if (dto.id == null) continue;
      final synced = await _upsert(dto);
      final failure = synced.fold<Failure?>((failure) => failure, (_) => null);
      if (failure != null) return Left(failure);
    }

    final refreshed = await _localDataSource.getTodoItems(
      taskListLocalId: taskListLocalId,
      isPendingDeletion: false,
    );
    return _pageFromLocal(refreshed, nextUrl: page.next);
  }

  Future<Either<Failure, TodoItemPage>> _pageFromLocal(
    Either<Failure, List<TodoItemEntity>> result, {
    String? nextUrl,
  }) async {
    return result.fold((failure) => Left(failure), (items) async {
      final entities = <TodoItemEntity>[];
      for (final item in items) {
        final tags = await _localDataSource.getTagsForTodoItem(item.localId);
        final failure = tags.fold<Failure?>((failure) => failure, (_) => null);
        if (failure != null) return Left(failure);
        entities.add(
          item.toDomain(tags: tags.fold((_) => [], (value) => value)),
        );
      }
      return Right(TodoItemPage(items: entities, nextUrl: nextUrl));
    });
  }

  Future<Either<Failure, TodoItemEntity>> getTodoItemById(String id) async {
    final localResult = await _localDataSource.getTodoItemByExternalID(id);
    return localResult.fold((failure) => Left(failure), (localItem) async {
      if (localItem != null && !localItem.isDirty) {
        return _itemWithTags(localItem);
      }

      final remoteResult = await _remoteDataSource.getTodoItemById(id);
      return remoteResult.fold(
        (failure) =>
            localItem == null ? Left(failure) : _itemWithTags(localItem),
        (dto) async {
          final synced = await _upsert(dto, localItem: localItem);
          return synced.fold(
            (failure) => Left(failure),
            (item) => _itemWithTags(item),
          );
        },
      );
    });
  }

  Future<Either<Failure, TodoItemEntity>> _itemWithTags(
    TodoItemEntity item,
  ) async {
    final tags = await _localDataSource.getTagsForTodoItem(item.localId);
    return tags.map((resolved) => item.toDomain(tags: resolved));
  }

  Future<Either<Failure, TodoItemEntity>> _upsert(
    TodoItemDto dto, {
    TodoItemEntity? localItem,
  }) async {
    final existing = localItem == null
        ? await _localDataSource.getTodoItemByExternalID(dto.id!)
        : Right<Failure, TodoItemEntity?>(localItem);
    return existing.fold((failure) => Left(failure), (current) async {
      var listLocalId = current?.taskListLocalId ?? 0;
      if (listLocalId == 0 || dto.taskList != null) {
        final resolved = await _tagResolver.resolveTaskListLocalIdResult(
          dto.taskList,
        );
        final failure = resolved.fold<Failure?>(
          (failure) => failure,
          (_) => null,
        );
        if (failure != null) return Left(failure);
        listLocalId = resolved.fold((_) => 0, (id) => id);
      }
      final dataModel = dto.toDataModel(
        localId: current?.localId ?? 0,
        taskListLocalId: listLocalId,
        isDirty: false,
        focusedSeconds: current?.focusedSeconds ?? 0,
      );
      final saved = current == null
          ? await _localDataSource.createTodoItem(dataModel)
          : await _localDataSource.updateTodoItem(dataModel);
      return saved.fold((failure) => Left(failure), (item) async {
        final tagLocalIds = await _tagResolver.resolveTagUuidsToLocalIds(
          dto.tags,
        );
        final failure = tagLocalIds.fold<Failure?>(
          (failure) => failure,
          (_) => null,
        );
        if (failure != null) return Left(failure);
        final syncedTags = await _localDataSource.syncTagsForTodoItem(
          todoLocalId: item.localId,
          tagLocalIds: tagLocalIds.fold((_) => [], (ids) => ids),
        );
        return syncedTags.map((_) => item);
      });
    });
  }
}
