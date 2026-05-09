import 'package:academia/core/core.dart';
import 'package:drift/drift.dart';

@DataClassName('TicketData')
class TicketTable extends Table {
  TextColumn get id => text().nullable()();

  @JsonKey('event_id')
  TextColumn get eventId => text().nullable()();

  @JsonKey('ticket_name')
  TextColumn get ticketName => text()();

  @JsonKey('ticket_price')
  IntColumn get ticketPrice => integer()();

  @JsonKey('ticket_quantity')
  IntColumn get ticketQuantity => integer().nullable()();

  @JsonKey('ticket_for')
  IntColumn get ticketFor => integer().nullable()();

  @JsonKey('institutions')
  TextColumn get institutions => text().map(JsonListConverter()).nullable()();

  @JsonKey('scope')
  TextColumn get scope => text().nullable()();
}
