import 'package:academia/database/database.dart';
import 'package:academia/features/sherehe/domain/domain.dart';

extension TicketStatsModelHelper on TicketStatsData {
  TicketStats toEntity() => TicketStats(
    ticketId: ticketId,
    ticketName: ticketName,
    ticketPrice: ticketPrice,
    ticketsSold: ticketsSold,
    ticketsRemaining: ticketsRemaining,
  );
}

extension TicketStatsEntityHelper on TicketStats {
  TicketStatsData toModel() => TicketStatsData(
    ticketId: ticketId,
    ticketName: ticketName,
    ticketPrice: ticketPrice,
    ticketsSold: ticketsSold,
    ticketsRemaining: ticketsRemaining,
  );
}
