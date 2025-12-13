part of 'user_event_tickets_bloc.dart';

abstract class UserEventTicketsEvent extends Equatable {
  const UserEventTicketsEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserEventTickets extends UserEventTicketsEvent {
  final int page;
  final int limit;

  const FetchUserEventTickets({required this.page, required this.limit});

  @override
  List<Object?> get props => [page, limit];
}
