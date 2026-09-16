import 'package:academia/features/todos/domain/enums/sync_status.dart';
import 'package:drift/drift.dart';

class TodoLists extends Table {
  IntColumn get localId => integer().autoIncrement()();
  TextColumn get id => text().unique().nullable()();

  TextColumn get title => text().withLength(min: 1, max: 255)();
  IntColumn get color => integer().nullable()();
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
