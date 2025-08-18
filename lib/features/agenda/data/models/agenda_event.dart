import 'package:academia/core/data/json_converter.dart';
import 'package:drift/drift.dart';

@DataClassName("AgendaEventData")
class AgendaEvent extends Table {
  TextColumn get id => text()(); // Primary key from Google Calendar
  @JsonKey("all_day")
  BoolColumn get allDay => boolean().withDefault(const Constant(false))();
  @JsonKey("summary")
  TextColumn get summary => text().nullable()();

  @JsonKey("description")
  TextColumn get description => text().nullable()();

  @JsonKey("location")
  TextColumn get location => text().nullable()();

  @JsonKey("html_link")
  TextColumn get htmlLink => text().nullable()();

  @JsonKey("calendar_id")
  TextColumn get calendarId => text().nullable()();

  @JsonKey("owner_id")
  TextColumn get ownerId => text().nullable()();
  TextColumn get timezone => text().nullable()();
  TextColumn get status => text().nullable()();
  TextColumn get transparency => text().nullable()();
  TextColumn get etag => text().nullable()();
  DateTimeColumn get created => dateTime().nullable()();
  DateTimeColumn get updated => dateTime().nullable()();
  @JsonKey("start_time")
  DateTimeColumn get startTime => dateTime().nullable()();

  @JsonKey("end_time")
  DateTimeColumn get endTime => dateTime().nullable()();

  // JSON blobs for flexibility
  TextColumn get attendees =>
      text().map(const JsonListConverter()).nullable()();
  TextColumn get recurrence =>
      text().map(const JsonListConverter()).nullable()();
  TextColumn get reminders => text().map(const JsonConverter()).nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
