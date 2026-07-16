import 'package:drift/drift.dart';

@DataClassName("ExamTimetableData")
class ExamTimetable extends Table {
  @JsonKey("course_code")
  TextColumn get courseCode => text()();

  @JsonKey("start_time")
  TextColumn get startTime => text()();

  @JsonKey("end_time")
  TextColumn get endTime => text()();

  TextColumn get venue => text()();

  @JsonKey("coordinator")
  TextColumn get coordinator => text().withDefault(const Constant(''))();

  TextColumn get hrs => text().withDefault(const Constant(''))();

  /// Stores the raw_data JSON blob as a string (nullable).
  @JsonKey("raw_data")
  TextColumn get rawData => text().nullable()();

  /// Parsed from start_time ISO string; used for sorting / countdown.
  @JsonKey("datetime_str")
  DateTimeColumn get datetimeStr => dateTime()();

  @override
  Set<Column> get primaryKey => {courseCode};
}
