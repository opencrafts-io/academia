import 'package:drift/drift.dart';

class Plans extends Table {
  IntColumn get id => integer()();
  BoolColumn get active => boolean()();
  IntColumn get billingIntervalDays => integer()();
  TextColumn get code => text().unique()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get createdBy => text()();
  TextColumn get currency => text()();
  TextColumn get description => text()();
  TextColumn get name => text()();
  RealColumn get price => real()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get visible => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}
