import 'package:drift/drift.dart';

class BillingOrders extends Table {
  TextColumn get id => text()();
  TextColumn get currency => text()();
  IntColumn get discount => integer()();
  DateTimeColumn get expiresAt => dateTime().nullable()();
  TextColumn get metadata => text()();
  DateTimeColumn get paidAt => dateTime().nullable()();
  TextColumn get status => text()();
  IntColumn get subtotal => integer()();
  IntColumn get tax => integer()();
  IntColumn get total => integer()();
  TextColumn get userId => text().nullable()();
  DateTimeColumn get cancelledAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
