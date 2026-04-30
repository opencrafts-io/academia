import 'package:academia/core/data/color_converter.dart';
import 'package:drift/drift.dart';

enum SyncStatus { pending, synced, failed }

class TodoLists extends Table {
  IntColumn get localId => integer().autoIncrement()();
  TextColumn get id => text().unique().nullable()();

  TextColumn get title => text().withLength(min: 1, max: 255)();
  IntColumn get color => integer().nullable().map(const ColorConverter())();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();

  TextColumn get syncStatus =>
      textEnum<SyncStatus>().withDefault(Constant(SyncStatus.pending.name))();

  IntColumn get taskCount => integer().withDefault(const Constant(0))();

  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  BoolColumn get isPendingDeletion =>
      boolean().withDefault(const Constant(false))();

  BoolColumn get isDirty => boolean().withDefault(const Constant(true))();
}
