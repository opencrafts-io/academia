import '../../domain/entities/ticket.dart';
import 'ticket_model.dart';

extension TicketModelHelper on TicketModel {
  Ticket toEntity() => Ticket(
    id: id,
    attendeeId: attendeeId,
    eventId: eventId,
    paymentCode: paymentCode,
    createdAt: createdAt,
  );
}

extension TicketEntityHelper on Ticket {
  TicketModel toModel() => TicketModel(
    id: id,
    attendeeId: attendeeId,
    eventId: eventId,
    paymentCode: paymentCode,
    createdAt: createdAt,
  );
}
