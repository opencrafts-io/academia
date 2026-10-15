import 'package:database/app_database_v2.dart';
import 'package:database/tables/tables.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

part 'todo_list_dao.g.dart';

@injectable
@DriftAccessor(tables: [TodoLists])
class TodoListDao extends DatabaseAccessor<AppDatabaseV2>
    with _$TodoListDaoMixin {
  TodoListDao(super.db);

  Future<TodoList> create(TodoListsCompanion list) => into(todoLists)
      .insertReturning(
        list.copyWith(localId: const Value.absent()),
        mode: InsertMode.insert,
      );

  Future<List<TodoList>> getAll({bool? isDirty, bool? isPendingDeletion}) {
    final query = select(todoLists)
      ..where((list) {
        final conditions = <Expression<bool>>[];
        if (isDirty != null) conditions.add(list.isDirty.equals(isDirty));
        if (isPendingDeletion != null) {
          conditions.add(list.isPendingDeletion.equals(isPendingDeletion));
        }
        return conditions.isEmpty
            ? const Constant(true)
            : conditions.reduce((left, right) => left & right);
      })
      ..orderBy([
        (list) => OrderingTerm(
          expression: coalesce([list.updatedAt, list.createdAt]),
          mode: OrderingMode.desc,
        ),
        (list) => OrderingTerm(expression: list.title),
      ]);
    return query.get();
  }

  Future<TodoList?> getByLocalId(int localId) => (select(
    todoLists,
  )..where((list) => list.localId.equals(localId))).getSingleOrNull();

  Future<TodoList?> getById(String id) => (select(
    todoLists,
  )..where((list) => list.id.equals(id))).getSingleOrNull();

  Future<TodoList?> updateList(TodoListsCompanion list, int localId) async {
    final count = await (update(
      todoLists,
    )..where((row) => row.localId.equals(localId))).write(list);
    if (count == 0) return null;
    return getByLocalId(localId);
  }

  Future<TodoList?> softDelete(TodoListsCompanion list, int localId) =>
      updateList(
        list.copyWith(
          isPendingDeletion: const Value(true),
          isDirty: const Value(true),
        ),
        localId,
      );

  Future<int> hardDelete(int localId) =>
      (delete(todoLists)..where((row) => row.localId.equals(localId))).go();
}
