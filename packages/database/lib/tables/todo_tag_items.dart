import 'package:drift/drift.dart';

class TodoTagItems extends Table {
  IntColumn get localId => integer().autoIncrement()();
  TextColumn get id => text().unique().nullable()();

  TextColumn get name => text().withLength(min: 1, max: 255)();

  TextColumn get color => text().nullable()();

  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  DateTimeColumn get createdAt => dateTime().nullable()();

  BoolColumn get isPendingDeletion =>
      boolean().withDefault(const Constant(false))();

  BoolColumn get isDirty => boolean().withDefault(const Constant(true))();
}
