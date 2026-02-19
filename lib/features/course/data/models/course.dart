import 'package:academia/core/core.dart';
import 'package:academia/features/institution/data/models/institution.dart';
import 'package:academia/features/semester/data/models/semester.dart';
import 'package:drift/drift.dart';

class Course extends Table {
  @JsonKey("cache_id")
  TextColumn get id => text().clientDefault(generateUuid)();

  @JsonKey("id")
  IntColumn get serverId => integer().unique().nullable()();

  IntColumn get institution =>
      integer().nullable().references(Institution, #institutionId)();

  IntColumn get semester => integer().nullable().references(Semester, #id)();

  @JsonKey("course_code")
  TextColumn get courseCode => text()();

  @JsonKey("course_name")
  TextColumn get courseName => text()();

  @JsonKey("instructor")
  TextColumn get instructor => text()();

  IntColumn get color => integer()
      .map(ColorConverter())
      .nullable()
      .withDefault(Constant(0x1E1E2EFF))();

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
