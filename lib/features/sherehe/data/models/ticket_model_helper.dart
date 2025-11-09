import 'package:academia/database/database.dart';
import 'package:academia/features/sherehe/domain/entities/ticket.dart';

extension TicketModelHelper on TicketData {
  Ticket toEntity() => Ticket(
    id: id,
    eventId: eventId,
    ticketName: ticketName,
    ticketPrice: ticketPrice,
    ticketQuantity: ticketQuantity,
    deleteTag: deleteTag ?? false,
    createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
    updatedAt: updatedAt != null ? DateTime.tryParse(updatedAt!) : null,
  );
}

extension TicketEntityHelper on Ticket {
  TicketData toModel() => TicketData(
    id: id,
    eventId: eventId,
    ticketName: ticketName,
    ticketPrice: ticketPrice,
    ticketQuantity: ticketQuantity,
    deleteTag: deleteTag,
    createdAt: createdAt?.toIso8601String(),
    updatedAt: updatedAt?.toIso8601String(),
  );
}
