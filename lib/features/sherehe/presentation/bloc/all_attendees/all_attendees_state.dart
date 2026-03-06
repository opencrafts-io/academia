part of 'all_attendees_bloc.dart';

abstract class AllAttendeesState extends Equatable {
  const AllAttendeesState();

  @override
  List<Object?> get props => [];
}

class AllAttendeesStateInitial extends AllAttendeesState {}

class AllAttendeesStateLoading extends AllAttendeesState {}

class AllAttendeesStatePaginationLoading extends AllAttendeesState {
  final List<Attendee> existingAttendee;
  final bool hasMore;

  const AllAttendeesStatePaginationLoading({
    required this.existingAttendee,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [existingAttendee, hasMore];
}

class AllAttendeesStateLoaded extends AllAttendeesState {
  final List<Attendee> attendees;
  final bool hasMore;

  const AllAttendeesStateLoaded({required this.attendees, this.hasMore = false});
  AllAttendeesStateLoaded copyWith({List<Attendee>? attendees, bool? hasMore}) {
    return AllAttendeesStateLoaded(
      attendees: attendees ?? this.attendees,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [attendees, hasMore];
}

class AllAttendeesStateError extends AllAttendeesState {
  final String message;

  const AllAttendeesStateError(this.message);

  @override
  List<Object?> get props => [message];
}

class AllAttendeesStatePaginationError extends AllAttendeesState {
  final List<Attendee> existingAttendee;
  final String message;
  final bool hasMore;

  const AllAttendeesStatePaginationError({
    required this.existingAttendee,
    required this.message,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [existingAttendee, message, hasMore];
}