import 'package:drift/drift.dart';
import 'package:academia/core/core.dart';

class InstitutionProfile extends Table {
  IntColumn get id => integer().nullable()();

  @JsonKey("user_id")
  TextColumn get userID => text().named("user_id")();

  @JsonKey("institution")
  IntColumn get institutionID => integer().named("institution_id")();

  @JsonKey("student_id")
  TextColumn get studentID => text().named("student_id").unique()();

  @JsonKey("national_id")
  TextColumn get nationalID => text().named("national_id").nullable()();

  @JsonKey("nationality")
  TextColumn get nationality => text().nullable()();

  TextColumn get program => text().nullable()();
  TextColumn get major => text().nullable()();
  IntColumn get year => integer().nullable()();
  RealColumn get gpa => real().nullable()();

  @JsonKey("disability_status")
  TextColumn get disabilityStatus => text().nullable()();
  TextColumn get school => text().nullable()();

  TextColumn get phone => text().nullable()();
  TextColumn get address => text().nullable()();

  @JsonKey("enrollment_date")
  DateTimeColumn get enrollmentDate => dateTime().nullable()();

  @JsonKey("expected_graduation")
  DateTimeColumn get expectedGraduation => dateTime().nullable()();

  @JsonKey("raw_data")
  TextColumn get rawData => text().map(const JsonConverter()).nullable()();

  @JsonKey("created_at")
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @JsonKey("updated_at")
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>>? get primaryKey => {institutionID, userID};
}
