import 'package:academia/database/database.dart';
import 'package:academia/features/sherehe/data/models/sherehe_user_model_helper.dart';
import 'package:academia/features/sherehe/data/models/ticket_model_helper.dart';
import 'package:academia/features/sherehe/data/models/event_model_helper.dart';
import 'package:academia/features/sherehe/domain/entities/attendee.dart';

extension AttendeeModelHelper on AttendeeData {
  Attendee toEntity() => Attendee(
    id: id,
    userId: userId,
    eventId: eventId,
    ticketId: ticketId,
    ticketQuantity: ticketQuantity,
    user: user != null ? ShereheUserData.fromJson(user!).toEntity() : null,
    ticket: ticket != null ? TicketData.fromJson(ticket!).toEntity() : null,
    event: event != null ? EventData.fromJson(event!).toEntity() : null,
  );
}

extension AttendeeEntityHelper on Attendee {
  AttendeeData toModel() => AttendeeData(
    id: id,
    userId: userId,
    eventId: eventId,
    ticketId: ticketId,
    ticketQuantity: ticketQuantity,
    user: user?.toModel().toJson(),
    ticket: ticket?.toModel().toJson(),
    event: event?.toModel().toJson(),
  );
}
