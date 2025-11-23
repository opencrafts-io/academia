part of 'user_ticket_selection_bloc.dart';

abstract class UserTicketSelectionEvent extends Equatable {
  const UserTicketSelectionEvent();

  @override
  List<Object?> get props => [];
}

class FetchTicketsByEventId extends UserTicketSelectionEvent {
  final String eventId;

  const FetchTicketsByEventId({required this.eventId});

  @override
  List<Object?> get props => [eventId];
}

class PurchaseTicket extends UserTicketSelectionEvent {
  final String ticketId;
  final int ticketQuantity;

  const PurchaseTicket({
    required this.ticketId,
    required this.ticketQuantity,
  });

  @override
  List<Object?> get props => [ticketId, ticketQuantity];
}
