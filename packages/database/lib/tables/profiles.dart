import 'package:drift/drift.dart';

class Profiles extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get username => text().nullable()();
  TextColumn get email => text()();
  BoolColumn get termsAccepted =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get onboarded => boolean().withDefault(const Constant(false))();
  TextColumn get nationalId => text().nullable()();
  TextColumn get avatarUrl => text().nullable()();
  TextColumn get bio => text().nullable()();
  TextColumn get phone => text().nullable()();
  IntColumn get vibePoints => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
