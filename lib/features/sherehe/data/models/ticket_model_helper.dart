import 'package:academia/database/database.dart';
import 'package:academia/features/sherehe/domain/entities/ticket.dart';

extension TicketModelHelper on TicketData {
  Ticket toEntity() => Ticket(
    id: id,
    eventId: eventId,
    ticketName: ticketName,
    ticketPrice: ticketPrice,
    ticketQuantity: ticketQuantity,
    ticketFor: ticketFor,
    institutionIds: institutions
        ?.map((e) => int.tryParse(e))
        .whereType<int>()
        .toList(),
    scope: scope,
  );
}

extension TicketEntityHelper on Ticket {
  TicketData toModel() => TicketData(
    id: id,
    eventId: eventId,
    ticketName: ticketName,
    ticketPrice: ticketPrice,
    ticketQuantity: ticketQuantity,
    ticketFor: ticketFor,
    institutions: institutionIds?.map((e) => e.toString()).toList(),
    scope: scope,
  );
}
