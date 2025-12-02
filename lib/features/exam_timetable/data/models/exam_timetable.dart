import 'package:drift/drift.dart';

@DataClassName("ExamTimetableData")
class ExamTimetable extends Table {
  @JsonKey("course_code")
  TextColumn get courseCode => text()();

  @JsonKey("institution_id")
  TextColumn get institutionId => text()();

  TextColumn get day => text()();
  TextColumn get time => text()();
  TextColumn get venue => text()();
  TextColumn get hrs => text()();
  TextColumn get campus => text()();
  TextColumn get coordinator => text()();
  TextColumn get invigilator => text()();

  @JsonKey("datetime_str")
  DateTimeColumn get datetimeStr => dateTime()();

  @override
  Set<Column> get primaryKey => {courseCode, institutionId};
}
