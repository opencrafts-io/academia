import 'package:academia/core/core.dart';
import 'package:drift/drift.dart';

@DataClassName('AttendeeData')
class AttendeeTable extends Table {
  TextColumn get id => text()();

  @JsonKey('user_id')
  TextColumn get userId => text()();

  @JsonKey('event_id')
  TextColumn get eventId => text()();

  @JsonKey('ticket_id')
  TextColumn get ticketId => text()();

  @JsonKey('ticket_quantity')
  IntColumn get ticketQuantity => integer()();

  TextColumn get user => text().map(JsonConverter()).nullable()();

  TextColumn get ticket => text().map(JsonConverter()).nullable()();

  TextColumn get event => text().map(JsonConverter()).nullable()();
}
