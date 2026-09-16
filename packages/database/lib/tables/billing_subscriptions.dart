import 'package:drift/drift.dart';

class BillingSubscriptions extends Table {
  IntColumn get id => integer()();
  TextColumn get planCode => text()();
  IntColumn get planId => integer()();
  TextColumn get planName => text()();
  TextColumn get status => text()();
  BoolColumn get cancelAtPeriodEnd => boolean()();
  DateTimeColumn get cancelledAt => dateTime().nullable()();
  DateTimeColumn get currentPeriodEnd => dateTime()();
  DateTimeColumn get currentPeriodStart => dateTime()();
  DateTimeColumn get startedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
