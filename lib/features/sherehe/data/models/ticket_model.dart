

import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/data/models/attendee_model.dart';
import 'package:academia/features/sherehe/data/models/event_model.dart';
import 'package:drift/drift.dart';

@DataClassName('TicketData')
class TicketTable extends Table with TableMixin{
  @JsonKey('attendee_id')
  TextColumn get attendeeId => text().references(AttendeeTable, #id)();

  @JsonKey('event_id')
  TextColumn get eventId => text().references(EventTable, #id)();

  @JsonKey('payment_code')
  TextColumn get paymentCode => text()();

  @override
  Set<Column> get primaryKey => {id};
}