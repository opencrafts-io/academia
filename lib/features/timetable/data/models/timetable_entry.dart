import 'package:academia/features/course/data/models/course.dart';
import 'package:drift/drift.dart';
import 'package:academia/core/core.dart';


import './timetable.dart';

class TimetableEntry extends Table {
  @JsonKey("cache_id")
  TextColumn get id => text().clientDefault(generateUuid)();

  @JsonKey("id")
  IntColumn get serverId => integer().unique().nullable()();

  @JsonKey("user_id")
  TextColumn get userId => text()();

  @JsonKey("institution_id")
  // 1. Define uuid as a top-level global so the genera
  IntColumn get institutionId => integer()();

  @JsonKey("course_id")
  TextColumn get courseId => text().references(Course, #id)();

  @JsonKey("timetable_id")
  TextColumn get timetableId => text().references(Timetable, #id)();

  /// This allows the app to calculate occurrences offline.
  TextColumn get rrule => text().nullable()();

  /// For one-off events or the "Anchor" date for the RRULE
  @JsonKey("start_date")
  DateTimeColumn get startDate => dateTime()();

  /// Duration in minutes (better than storing a hard EndDate for recurring events)
  IntColumn get durationMinutes => integer()();

  @JsonKey("location")
  TextColumn get location => text().nullable()();

  @JsonKey("room")
  TextColumn get room => text().nullable()();

  @JsonKey("building")
  TextColumn get building => text().nullable()();

  @JsonKey("is_synced")
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

  @JsonKey("is_deleted")
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @JsonKey("last_updated")
  DateTimeColumn get lastUpdated =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
