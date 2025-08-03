import 'package:academia/database/database.dart';
import 'package:academia/features/sherehe/domain/entities/ticket.dart';

extension TicketModelHelper on TicketData {
  Ticket toEntity() => Ticket(
    id: id,
    attendeeId: attendeeId,
    eventId: eventId,
    paymentCode: paymentCode,
    createdAt: createdAt,
  );
}

extension TicketEntityHelper on Ticket {
  TicketData toModel() => TicketData(
    id: id,
    attendeeId: attendeeId,
    eventId: eventId,
    paymentCode: paymentCode,
    createdAt: createdAt,
    updatedAt: DateTime.now()
  );
}
