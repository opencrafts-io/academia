import 'package:drift/drift.dart';
import './institution.dart';

enum Weekday { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

class InstitutionCourseTimetableEntry extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get institution =>
      integer().nullable().references(Institution, #institutionId)();

  @JsonKey("course_code")
  TextColumn get courseCode => text()();

  @JsonKey("course_name")
  TextColumn get courseName => text()();

  @JsonKey("day_of_week")
  IntColumn get dayOfWeek => intEnum<Weekday>()();

  @JsonKey("start_time")
  DateTimeColumn get startTime => dateTime()();

  @JsonKey("end_time")
  DateTimeColumn get endTime => dateTime()();

  TextColumn get location => text().nullable()();
  TextColumn get room => text().nullable()();
  TextColumn get building => text().nullable()();
  TextColumn get instructor => text().nullable()();

  @JsonKey("is_recurring")
  BoolColumn get isRecurring => boolean().withDefault(const Constant(true))();

  @JsonKey("recurrence_pattern")
  TextColumn get recurrencePattern => text().nullable()();

  @JsonKey("raw_data")
  TextColumn get rawData => text().nullable()();

  @JsonKey("created_at")
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @JsonKey("updated_at")
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
