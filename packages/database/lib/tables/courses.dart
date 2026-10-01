import 'package:drift/drift.dart';

class Courses extends Table {
  TextColumn get id => text()();
  TextColumn get serverId => text().nullable()();
  TextColumn get idempotencyKey => text().withDefault(const Constant(''))();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();
  TextColumn get lastSyncError => text().nullable()();
  IntColumn get institutionId => integer()();
  TextColumn get title => text()();
  TextColumn get code => text().nullable()();
  TextColumn get color => text().nullable()();
  TextColumn get termLabel => text().nullable()();
  TextColumn get academicYear => text().nullable()();
  DateTimeColumn get termStartDate => dateTime().nullable()();
  DateTimeColumn get termEndDate => dateTime().nullable()();
  TextColumn get previousCourseId => text().nullable()();
  DateTimeColumn get archivedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
