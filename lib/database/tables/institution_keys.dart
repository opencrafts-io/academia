import 'package:academia/database/tables/institutions.dart';
import 'package:academia/database/tables/institution_scrapping_commands.dart';
import 'package:drift/drift.dart';
import 'package:academia/core/core.dart';

class InstitutionKeys extends Table {
  @override
  String get tableName => 'institution_key';

  @JsonKey("institution_id")
  IntColumn get institutionID => integer()
      .named('institution_id')
      .references(Institutions, #institutionId)();

  @JsonKey("command_id")
  TextColumn get commandID =>
      text().references(InstitutionScrappingCommands, #commandID)();

  @JsonKey("key_sets")
  TextColumn get keySets => text().map(JsonConverter())();

  @JsonKey("created_at")
  DateTimeColumn get createdAt =>
      dateTime().nullable().withDefault(Constant(DateTime.now()))();

  @override
  Set<Column<Object>>? get primaryKey => {institutionID, commandID};
}
