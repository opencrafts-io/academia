import 'package:drift/drift.dart';

import 'courses.dart';

class Lecturers extends Table {
  TextColumn get id => text()();
  TextColumn get studentCourseId => text().references(Courses, #id)();
  TextColumn get name => text()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get office => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
