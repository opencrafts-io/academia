import 'package:academia/database/tables/tables.dart';
import 'package:drift/drift.dart';

class Semester extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  IntColumn get institutionId =>
      integer().references(Institutions, #institutionId).nullable()();
  @JsonKey("start_date")
  DateTimeColumn get startDate => dateTime().withDefault(currentDateAndTime)();
  @JsonKey("end_date")
  DateTimeColumn get endDate => dateTime().withDefault(currentDateAndTime)();
}
