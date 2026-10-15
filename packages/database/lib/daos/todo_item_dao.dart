import 'package:database/app_database_v2.dart';
import 'package:database/tables/tables.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

part 'todo_item_dao.g.dart';

@injectable
@DriftAccessor(tables: [TodoItems, TodoTagItems, TodoItemTags])
class TodoItemDao extends DatabaseAccessor<AppDatabaseV2>
    with _$TodoItemDaoMixin {
  TodoItemDao(super.db);

  Future<TodoItem> create(TodoItemsCompanion item) => into(todoItems)
      .insertReturning(
        item.copyWith(
          localId: const Value.absent(),
          isDirty: const Value(true),
        ),
        mode: InsertMode.insert,
      );

  Future<List<TodoItem>> getAll({
    int? taskListLocalId,
    bool? isDirty,
    bool? isPendingDeletion,
    String? status,
    String? priority,
  }) {
    final query = select(todoItems)
      ..where((item) {
        final conditions = <Expression<bool>>[];
        if (taskListLocalId != null) {
          conditions.add(item.taskListLocalId.equals(taskListLocalId));
        }
        if (isDirty != null) conditions.add(item.isDirty.equals(isDirty));
        if (isPendingDeletion != null) {
          conditions.add(item.isPendingDeletion.equals(isPendingDeletion));
        }
        if (status != null) conditions.add(item.status.equals(status));
        if (priority != null) conditions.add(item.priority.equals(priority));
        return conditions.isEmpty
            ? const Constant(true)
            : conditions.reduce((left, right) => left & right);
      })
      ..orderBy([
        (item) => OrderingTerm(expression: item.due),
        (item) => OrderingTerm(expression: item.position),
        (item) =>
            OrderingTerm(expression: item.createdAt, mode: OrderingMode.desc),
      ]);
    return query.get();
  }

  Future<TodoItem?> getByLocalId(int localId) => (select(
    todoItems,
  )..where((item) => item.localId.equals(localId))).getSingleOrNull();

  Future<TodoItem?> getById(String id) => (select(
    todoItems,
  )..where((item) => item.id.equals(id))).getSingleOrNull();

  Future<TodoItem?> updateItem(TodoItemsCompanion item, int localId) async {
    final count = await (update(
      todoItems,
    )..where((row) => row.localId.equals(localId))).write(item);
    if (count == 0) return null;
    return getByLocalId(localId);
  }

  Future<TodoItem?> addFocusedTime(int localId, Duration duration) async {
    final count = await customUpdate(
      'UPDATE todo_items SET focused_seconds = focused_seconds + ?1 '
      'WHERE local_id = ?2',
      variables: [Variable<int>(duration.inSeconds), Variable<int>(localId)],
      updates: {todoItems},
      updateKind: UpdateKind.update,
    );
    if (count == 0) return null;
    return getByLocalId(localId);
  }

  Future<TodoItem?> softDelete(TodoItemsCompanion item, int localId) =>
      updateItem(
        item.copyWith(
          isPendingDeletion: const Value(true),
          isDirty: const Value(true),
        ),
        localId,
      );

  Future<int> hardDelete(int localId) =>
      (delete(todoItems)..where((item) => item.localId.equals(localId))).go();

  Future<void> addTag({required int todoLocalId, required int tagLocalId}) =>
      into(todoItemTags).insert(
        TodoItemTagsCompanion.insert(
          todoLocalId: todoLocalId,
          tagLocalId: tagLocalId,
        ),
        mode: InsertMode.insertOrIgnore,
      );

  Future<void> removeTag({
    required int todoLocalId,
    required int tagLocalId,
  }) async {
    await (delete(todoItemTags)..where(
          (itemTag) =>
              itemTag.todoLocalId.equals(todoLocalId) &
              itemTag.tagLocalId.equals(tagLocalId),
        ))
        .go();
  }

  Future<List<TodoTagItem>> getTags(int todoLocalId) async {
    final query = select(todoItemTags).join([
      innerJoin(
        todoTagItems,
        todoTagItems.localId.equalsExp(todoItemTags.tagLocalId),
      ),
    ])..where(todoItemTags.todoLocalId.equals(todoLocalId));
    final rows = await query.get();
    return rows.map((row) => row.readTable(todoTagItems)).toList();
  }

  Future<void> replaceTags({
    required int todoLocalId,
    required List<int> tagLocalIds,
  }) {
    return transaction(() async {
      await (delete(
        todoItemTags,
      )..where((itemTag) => itemTag.todoLocalId.equals(todoLocalId))).go();
      for (final tagLocalId in tagLocalIds) {
        await into(todoItemTags).insert(
          TodoItemTagsCompanion.insert(
            todoLocalId: todoLocalId,
            tagLocalId: tagLocalId,
          ),
        );
      }
    });
  }
}
