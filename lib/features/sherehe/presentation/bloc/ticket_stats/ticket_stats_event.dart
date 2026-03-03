part of 'ticket_stats_bloc.dart';

abstract class TicketStatsEvent extends Equatable {
  const TicketStatsEvent();

  @override
  List<Object> get props => [];
}

class GetTicketStats extends TicketStatsEvent {
  final String eventId;

  const GetTicketStats({required this.eventId});

  @override
  List<Object> get props => [eventId];
}

class UpdateTicketQuantity extends TicketStatsEvent {
  final String ticketId;
  final int ticketQuantity;

  const UpdateTicketQuantity({
    required this.ticketId,
    required this.ticketQuantity,
  });
  @override
  List<Object> get props => [ticketId, ticketQuantity];
}
