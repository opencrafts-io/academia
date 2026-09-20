import 'package:drift/drift.dart';

class Courses extends Table {
  TextColumn get id => text()();
  IntColumn get institutionId => integer()();
  TextColumn get title => text()();
  TextColumn get code => text().nullable()();
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
