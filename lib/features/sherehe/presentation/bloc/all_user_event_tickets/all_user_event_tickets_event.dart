part of 'all_user_event_tickets_bloc.dart';

abstract class AllUserEventTicketsEvent extends Equatable {
  const AllUserEventTicketsEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllUserTickets extends AllUserEventTicketsEvent {
  final int page;
  final int limit;

  const FetchAllUserTickets({required this.page, required this.limit});

  @override
  List<Object?> get props => [page, limit];
}

class SearchUserAttendedEvents extends AllUserEventTicketsEvent {
  final String query;

  const SearchUserAttendedEvents({required this.query});

  @override
  List<Object?> get props => [query];
}
