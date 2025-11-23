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
