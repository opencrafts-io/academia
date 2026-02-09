part of 'user_event_tickets_bloc.dart';

abstract class UserEventTicketsEvent extends Equatable {
  const UserEventTicketsEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserEventTickets extends UserEventTicketsEvent {
  final String eventId;
  final int page;
  final int limit;

  const FetchUserEventTickets({
    required this.eventId,
    required this.page,
    required this.limit,
  });

  @override
  List<Object?> get props => [eventId, page, limit];
}
