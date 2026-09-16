import 'package:drift/drift.dart';

class LockInAttempts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get appIdentifier => text()();
  TextColumn get appName => text()();
  TextColumn get ruleId => text().nullable()();
  DateTimeColumn get occurredAt => dateTime()();
}
