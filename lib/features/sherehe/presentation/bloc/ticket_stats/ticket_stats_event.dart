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
