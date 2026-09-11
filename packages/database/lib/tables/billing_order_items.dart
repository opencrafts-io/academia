import 'package:drift/drift.dart';

class BillingOrderItems extends Table {
  TextColumn get id => text()();
  TextColumn get orderId => text()();
  IntColumn get planId => integer()();
  IntColumn get quantity => integer()();
  IntColumn get unitPrice => integer()();
  IntColumn get discount => integer()();
  IntColumn get tax => integer()();
  TextColumn get addedBy => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
