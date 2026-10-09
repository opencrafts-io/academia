import 'package:drift/drift.dart';
import 'package:database/tables/todo_lists.dart';

class TodoItems extends Table {
  IntColumn get localId => integer().autoIncrement()();
  TextColumn get id => text().unique().nullable()();

  // Foreign key to TodoLists.localId
  IntColumn get taskListLocalId => integer().references(TodoLists, #localId)();

  TextColumn get title => text().withLength(min: 1, max: 255)();
  TextColumn get notes => text().nullable()();

  TextColumn get status => text().withDefault(const Constant('needsAction'))();

  TextColumn get priority => text().withDefault(const Constant('none'))();

  DateTimeColumn get due => dateTime().nullable()();
  DateTimeColumn get completed => dateTime().nullable()();

  IntColumn get subtaskCount => integer().withDefault(const Constant(0))();

  TextColumn get position => text().nullable()();

  BoolColumn get hidden => boolean().withDefault(const Constant(false))();

  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  BoolColumn get isPendingDeletion =>
      boolean().withDefault(const Constant(false))();

  BoolColumn get isDirty => boolean().withDefault(const Constant(true))();

  /// Cumulative seconds spent focusing on this task via linked Pomodoro
  /// sessions. Local-only — not part of the remote API.
  IntColumn get focusedSeconds => integer().withDefault(const Constant(0))();
}
