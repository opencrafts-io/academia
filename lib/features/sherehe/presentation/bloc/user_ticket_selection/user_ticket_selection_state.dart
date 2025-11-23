part of 'user_ticket_selection_bloc.dart';

abstract class UserTicketSelectionState extends Equatable {
  const UserTicketSelectionState();

  @override
  List<Object?> get props => [];
}

class UserTicketInitial extends UserTicketSelectionState {}

class UserTicketLoading extends UserTicketSelectionState {}

class UserTicketLoaded extends UserTicketSelectionState {
  final List<Ticket> tickets;

  const UserTicketLoaded({required this.tickets});

  @override
  List<Object?> get props => [tickets];
}

class UserTicketError extends UserTicketSelectionState {
  final String message;

  const UserTicketError(this.message);

  @override
  List<Object?> get props => [message];
}

class UserTicketPurchaseInProgress extends UserTicketSelectionState {
  final List<Ticket> existingTickets;

  const UserTicketPurchaseInProgress({required this.existingTickets});

  @override
  List<Object?> get props => [existingTickets];
}

class UserTicketPurchased extends UserTicketSelectionState {
  final Attendee attendee;

  const UserTicketPurchased({required this.attendee});

  @override
  List<Object?> get props => [attendee];
}

class UserTicketPurchaseFailed extends UserTicketSelectionState {
  final List<Ticket> existingTickets;
  final String message;

  const UserTicketPurchaseFailed({
    required this.existingTickets,
    required this.message,
  });

  @override
  List<Object?> get props => [existingTickets, message];
}
