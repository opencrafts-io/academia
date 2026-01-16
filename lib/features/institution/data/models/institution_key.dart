import 'package:academia/features/institution/data/models/institution.dart';
import 'package:academia/features/institution/data/models/institution_scrapping_command.dart';
import 'package:drift/drift.dart';
import 'package:academia/core/core.dart';

class InstitutionKey extends Table {
  @JsonKey("institution_id")
  IntColumn get institutionID => integer()
      .named('institution_id')
      .references(Institution, #institutionId)();

  @JsonKey("command_id")
  TextColumn get commandID =>
      text().references(InstitutionScrappingCommand, #commandID)();

  @JsonKey("key_sets")
  TextColumn get keySets => text().map(JsonConverter())();

  @JsonKey("created_at")
  DateTimeColumn get createdAt =>
      dateTime().nullable().withDefault(Constant(DateTime.now()))();

  @override
  Set<Column<Object>>? get primaryKey => {institutionID, commandID};
}
