import 'package:database/app_database_v2.dart';
import 'package:database/tables/tables.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

part 'todo_tag_dao.g.dart';

@injectable
@DriftAccessor(tables: [TodoTagItems])
class TodoTagDao extends DatabaseAccessor<AppDatabaseV2>
    with _$TodoTagDaoMixin {
  TodoTagDao(super.db);

  Future<TodoTagItem> create(TodoTagItemsCompanion tag) => into(todoTagItems)
      .insertReturning(
        tag.copyWith(localId: const Value.absent()),
        mode: InsertMode.insert,
      );

  Future<List<TodoTagItem>> getAll({bool? isDirty, bool? isPendingDeletion}) {
    final query = select(todoTagItems)
      ..where((tag) {
        final conditions = <Expression<bool>>[];
        if (isDirty != null) conditions.add(tag.isDirty.equals(isDirty));
        if (isPendingDeletion != null) {
          conditions.add(tag.isPendingDeletion.equals(isPendingDeletion));
        }
        return conditions.isEmpty
            ? const Constant(true)
            : conditions.reduce((left, right) => left & right);
      })
      ..orderBy([(tag) => OrderingTerm(expression: tag.name)]);
    return query.get();
  }

  Future<TodoTagItem?> getByLocalId(int localId) => (select(
    todoTagItems,
  )..where((tag) => tag.localId.equals(localId))).getSingleOrNull();

  Future<TodoTagItem?> getById(String id) => (select(
    todoTagItems,
  )..where((tag) => tag.id.equals(id))).getSingleOrNull();

  Future<TodoTagItem?> updateTag(TodoTagItemsCompanion tag, int localId) async {
    final count = await (update(
      todoTagItems,
    )..where((row) => row.localId.equals(localId))).write(tag);
    if (count == 0) return null;
    return getByLocalId(localId);
  }

  Future<TodoTagItem?> softDelete(TodoTagItemsCompanion tag, int localId) =>
      updateTag(
        tag.copyWith(
          isPendingDeletion: const Value(true),
          isDirty: const Value(true),
        ),
        localId,
      );

  Future<int> hardDelete(int localId) =>
      (delete(todoTagItems)..where((row) => row.localId.equals(localId))).go();
}
