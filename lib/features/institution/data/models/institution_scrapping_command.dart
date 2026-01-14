import 'package:academia/core/core.dart';
import 'package:drift/drift.dart';

class InstitutionScrappingCommand extends Table {
  @JsonKey("institution")
  IntColumn get institution => integer().named('institution')();

  @JsonKey("command_id")
  TextColumn get commandID => text()();

  @JsonKey("name")
  TextColumn get name => text()();

  @JsonKey("url")
  TextColumn get url => text().nullable()();

  @JsonKey("description")
  TextColumn get description => text().nullable()();

  @JsonKey("requires_interaction")
  BoolColumn get requiresInteraction =>
      boolean().withDefault(Constant(false))();

  @JsonKey("created_at")
  DateTimeColumn get createdAt =>
      dateTime().nullable().withDefault(Constant(DateTime.now()))();

  @JsonKey("instructions")
  TextColumn get instructions => text().map(JsonListConverter())();

  @override
  Set<Column<Object>>? get primaryKey => {commandID};
}
