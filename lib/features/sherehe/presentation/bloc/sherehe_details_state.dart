part of 'sherehe_details_bloc.dart';

abstract class ShereheDetailsState extends Equatable {
  const ShereheDetailsState();

  @override
  List<Object?> get props => [];
}

class ShereheDetailsInitial extends ShereheDetailsState {}

class ShereheDetailsLoading extends ShereheDetailsState {}

class ShereheDetailsLoaded extends ShereheDetailsState {
  final Event event;
  final List<Attendee> attendees;
  final bool isUserAttending;
  final UserProfile? currentUserProfile;

  const ShereheDetailsLoaded({
    required this.event,
    required this.attendees,
    this.isUserAttending = false,
    this.currentUserProfile,
  });

  ShereheDetailsLoaded copyWith({
    Event? event,
    List<Attendee>? attendees,
    bool? isUserAttending,
    UserProfile? currentUserProfile,
  }) {
    return ShereheDetailsLoaded(
      event: event ?? this.event,
      attendees: attendees ?? this.attendees,
      isUserAttending: isUserAttending ?? this.isUserAttending,
      currentUserProfile: currentUserProfile ?? this.currentUserProfile,
    );
  }

  @override
  List<Object?> get props => [
    event,
    attendees,
    isUserAttending,
    currentUserProfile,
  ];
}

class ShereheDetailsError extends ShereheDetailsState {
  final String message;

  const ShereheDetailsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class MarkingAsGoing extends ShereheDetailsState {}

class MarkedAsGoingSuccess extends ShereheDetailsState {}

class MarkedAsGoingFailure extends ShereheDetailsState {
  final String message;

  const MarkedAsGoingFailure({required this.message});

  @override
  List<Object?> get props => [message];
}