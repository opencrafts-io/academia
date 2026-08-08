part of 'ticket_stats_bloc.dart';

abstract class TicketStatsEvent extends Equatable {
  const TicketStatsEvent();

  @override
  List<Object?> get props => [];
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

class CreateTicket extends TicketStatsEvent {
  final String eventId;
  final String ticketName;
  final int ticketPrice;
  final int ticketFor;
  final int ticketQuantity;
  final String scope;
  final List<int>? institutions;
  final String startDate;
  final String endDate;

  const CreateTicket({
    required this.eventId,
    required this.ticketName,
    required this.ticketPrice,
    required this.ticketFor,
    required this.ticketQuantity,
    required this.scope,
    this.institutions,
    required this.startDate,
    required this.endDate,
  });
  @override
  List<Object?> get props => [
    eventId,
    ticketName,
    ticketPrice,
    ticketFor,
    ticketQuantity,
    scope,
    institutions,
    startDate,
    endDate,
  ];
}
