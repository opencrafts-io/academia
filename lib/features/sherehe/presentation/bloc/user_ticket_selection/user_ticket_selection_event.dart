part of 'user_ticket_selection_bloc.dart';

abstract class UserTicketSelectionEvent extends Equatable {
  const UserTicketSelectionEvent();

  @override
  List<Object?> get props => [];
}

class FetchTicketsByEventId extends UserTicketSelectionEvent {
  final String eventId;
  final String accountId;

  const FetchTicketsByEventId({required this.eventId, required this.accountId});

  @override
  List<Object?> get props => [eventId];
}
