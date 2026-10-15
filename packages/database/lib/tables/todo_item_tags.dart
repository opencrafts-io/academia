import 'package:drift/drift.dart';
import 'package:database/tables/todo_items.dart';
import 'package:database/tables/todo_tag_items.dart';

class TodoItemTags extends Table {
  IntColumn get todoLocalId => integer().references(TodoItems, #localId)();
  IntColumn get tagLocalId => integer().references(TodoTagItems, #localId)();

  // Composite primary key
  @override
  Set<Column> get primaryKey => {todoLocalId, tagLocalId};
}
