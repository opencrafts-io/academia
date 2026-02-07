import 'package:academia/features/institution/data/models/institution.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

final _uuid = Uuid();

class Timetable extends Table {
  @JsonKey("cache_id")
  TextColumn get id => text().nullable().clientDefault(() => _uuid.v4())();

  @JsonKey("id")
  IntColumn get serverId => integer().unique().nullable()();

  TextColumn get name => text()();

  @JsonKey("user_id")
  TextColumn get userId => text()();

  @JsonKey("institution_id")
  IntColumn get institution =>
      integer().nullable().references(Institution, #institutionId)();

  @JsonKey("is_synced")
  BoolColumn get isSynced => boolean().withDefault(Constant(false))();

  @JsonKey("is_deleted")
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @JsonKey("created_at")
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @JsonKey("updated_at")
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
