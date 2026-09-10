import 'package:drift/drift.dart';

class BillingSubscriptionStatuses extends Table {
  IntColumn get id => integer()();
  BoolColumn get active => boolean()();
  IntColumn get subscriptionId => integer().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
