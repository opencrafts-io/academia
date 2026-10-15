import 'package:drift/drift.dart';

import 'courses.dart';

class ScheduleEntries extends Table {
  TextColumn get id => text()();
  TextColumn get serverId => text().nullable()();
  TextColumn get idempotencyKey => text().withDefault(const Constant(''))();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();
  TextColumn get lastSyncError => text().nullable()();
  TextColumn get studentCourseId =>
      text().references(Courses, #id, onDelete: KeyAction.cascade)();
  TextColumn get dayOfWeek => text()();
  TextColumn get startTime => text()();
  TextColumn get endTime => text()();
  TextColumn get venue => text().nullable()();
  TextColumn get campus => text().nullable()();
  TextColumn get section => text().nullable()();
  TextColumn get label => text().nullable()();
  TextColumn get color => text().nullable()();
  BoolColumn get isRecurring => boolean().withDefault(const Constant(true))();
  DateTimeColumn get specificDate => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
