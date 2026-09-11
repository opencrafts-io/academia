import 'package:drift/drift.dart';

class LockInRuleRecords extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get appsJson => text()();
  TextColumn get weekdaysJson => text()();
  IntColumn get startMinutes => integer()();
  IntColumn get endMinutes => integer()();
  BoolColumn get enabled => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}
