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
  IntColumn get ticketQuantity => integer()();

  @JsonKey('delete_tag')
  BoolColumn get deleteTag => boolean().nullable()();

  @JsonKey('created_at')
  TextColumn get createdAt => text().nullable()();

  @JsonKey('updatedAt')
  TextColumn get updatedAt => text().nullable()();
}
