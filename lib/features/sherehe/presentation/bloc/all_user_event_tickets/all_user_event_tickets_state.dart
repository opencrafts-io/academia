part of 'all_user_event_tickets_bloc.dart';

abstract class AllUserEventTicketsState extends Equatable {
  const AllUserEventTicketsState();

  @override
  List<Object?> get props => [];
}

class UserAllTicketsInitial extends AllUserEventTicketsState {}

class UserAllTicketsLoading extends AllUserEventTicketsState {}

class UserAllTicketsPaginationLoading extends AllUserEventTicketsState {
  final List<Attendee> existingAttendee;
  final bool hasMore;

  const UserAllTicketsPaginationLoading({
    required this.existingAttendee,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [existingAttendee, hasMore];
}

class UserAllTicketsLoaded extends AllUserEventTicketsState {
  final List<Attendee> attendee;
  final bool hasMore;

  const UserAllTicketsLoaded({required this.attendee, this.hasMore = false});
  UserAllTicketsLoaded copyWith({List<Attendee>? attendee, bool? hasMore}) {
    return UserAllTicketsLoaded(
      attendee: attendee ?? this.attendee,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [attendee, hasMore];
}

class UserAllTicketsError extends AllUserEventTicketsState {
  final String message;

  const UserAllTicketsError(this.message);

  @override
  List<Object?> get props => [message];
}

class UserAllTicketsPaginationError extends AllUserEventTicketsState {
  final List<Attendee> existingAttendee;
  final String message;
  final bool hasMore;

  const UserAllTicketsPaginationError({
    required this.existingAttendee,
    required this.message,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [existingAttendee, message, hasMore];
}

class UserAllAttendedEventsSearchLoading extends AllUserEventTicketsState {}

class UserAllAttendedEventsLoaded extends AllUserEventTicketsState {
  final List<Attendee> attendee;

  const UserAllAttendedEventsLoaded({required this.attendee});

  @override
  List<Object?> get props => [attendee];
}

class UserAllAttendedEventsSearchError extends AllUserEventTicketsState {
  final String message;

  const UserAllAttendedEventsSearchError(this.message);

  @override
  List<Object?> get props => [message];
}
