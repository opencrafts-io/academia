part of 'user_ticket_selection_bloc.dart';

abstract class UserTicketSelectionEvent extends Equatable {
  const UserTicketSelectionEvent();

  @override
  List<Object?> get props => [];
}

class FetchTickets extends UserTicketSelectionEvent {
  final String? eventId;
  final String? invite;

  const FetchTickets({this.eventId, this.invite});

  @override
  List<Object?> get props => [eventId, invite];
}
