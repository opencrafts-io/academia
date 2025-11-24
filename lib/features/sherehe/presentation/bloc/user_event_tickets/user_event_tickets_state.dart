part of 'user_event_tickets_bloc.dart';

abstract class UserEventTicketsState extends Equatable {
  const UserEventTicketsState();

  @override
  List<Object?> get props => [];
}

class UserEventTicketInitial extends UserEventTicketsState {}

class UserEventTicketLoading extends UserEventTicketsState {}

class UserEventTicketPaginationLoading extends UserEventTicketsState {
  final List<Attendee> existingAttendee;
  final bool hasMore;

  const UserEventTicketPaginationLoading({
    required this.existingAttendee,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [existingAttendee, hasMore];
}

class UserEventTicketLoaded extends UserEventTicketsState {
  final List<Attendee> attendee;
  final bool hasMore;

  const UserEventTicketLoaded({required this.attendee, this.hasMore = false});

  UserEventTicketLoaded copyWith({List<Attendee>? attendee, bool? hasMore}) {
    return UserEventTicketLoaded(
      attendee: attendee ?? this.attendee,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [attendee, hasMore];
}

class UserEventTicketError extends UserEventTicketsState {
  final String message;

  const UserEventTicketError(this.message);

  @override
  List<Object?> get props => [message];
}

class UserEventTicketPaginationError extends UserEventTicketsState {
  final List<Attendee> existingAttendee;
  final String message;
  final bool hasMore;

  const UserEventTicketPaginationError({
    required this.existingAttendee,
    required this.message,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [existingAttendee, message, hasMore];
}
