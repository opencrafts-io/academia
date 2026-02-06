import 'package:academia/features/institution/data/models/institution.dart';
import 'package:drift/drift.dart';

class Semester extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  IntColumn get institutionId =>
      integer().references(Institution, #institutionId).nullable()();
  @JsonKey("start_date")
  DateTimeColumn get startDate => dateTime().withDefault(currentDateAndTime)();
  @JsonKey("end_date")
  DateTimeColumn get endDate => dateTime().withDefault(currentDateAndTime)();
}
