import 'package:drift/drift.dart';

class BillingEntitlements extends Table {
  TextColumn get planCode => text()();
  TextColumn get key => text()();
  TextColumn get description => text().nullable()();
  TextColumn get unit => text()();
  IntColumn get value => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {planCode, key};
}
