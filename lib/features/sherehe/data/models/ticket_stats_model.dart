import 'package:drift/drift.dart';

@DataClassName('TicketStatsData')
class TicketStatsTable extends Table {
  @JsonKey('ticket_id')
  TextColumn get ticketId => text()();

  @JsonKey('ticket_name')
  TextColumn get ticketName => text()();

  @JsonKey('ticket_price')
  IntColumn get ticketPrice => integer()();

  @JsonKey('tickets_sold')
  IntColumn get ticketsSold => integer()();

   @JsonKey('tickets_remaining')
  IntColumn get ticketsRemaining => integer()();
}
