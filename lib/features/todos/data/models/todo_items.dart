import 'package:academia/features/todos/domain/enums/sync_status.dart';
import 'package:academia/features/todos/domain/enums/todo_priority.dart';
import 'package:academia/features/todos/domain/enums/todo_status.dart';
import 'package:drift/drift.dart';
import 'todo_lists.dart';

class TodoItems extends Table {
  IntColumn get localId => integer().autoIncrement()();
  TextColumn get id => text().unique().nullable()();

  // Foreign key to TodoLists.localId
  IntColumn get taskListLocalId => integer().references(TodoLists, #localId)();

  TextColumn get title => text().withLength(min: 1, max: 255)();
  TextColumn get notes => text().nullable()();

  TextColumn get status => textEnum<TodoStatus>().withDefault(
    Constant(TodoStatus.needsAction.name),
  )();

  TextColumn get priority =>
      textEnum<TodoPriority>().withDefault(Constant(TodoPriority.none.name))();

  DateTimeColumn get due => dateTime().nullable()();
  DateTimeColumn get completed => dateTime().nullable()();

  IntColumn get subtaskCount => integer().withDefault(const Constant(0))();

  TextColumn get position => text().nullable()();

  BoolColumn get hidden => boolean().withDefault(const Constant(false))();

  TextColumn get syncStatus =>
      textEnum<SyncStatus>().withDefault(Constant(SyncStatus.pending.name))();

  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  BoolColumn get isPendingDeletion =>
      boolean().withDefault(const Constant(false))();

  BoolColumn get isDirty => boolean().withDefault(const Constant(true))();
}
