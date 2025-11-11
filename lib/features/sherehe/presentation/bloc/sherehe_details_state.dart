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
  final bool isLoadingAttendees;
  final bool showConfettiEffect;
  final String? attendeeErrorMessage;

  const ShereheDetailsLoaded({
    required this.event,
    required this.attendees,
    this.isUserAttending = false,
    this.isLoadingAttendees = false,
    this.attendeeErrorMessage,
    this.showConfettiEffect = false,
  });

  ShereheDetailsLoaded copyWith({
    Event? event,
    List<Attendee>? attendees,
    bool? isUserAttending,
    bool? isLoadingAttendees,
    String? attendeeErrorMessage,
    bool? showConfettiEffect,
  }) {
    return ShereheDetailsLoaded(
      event: event ?? this.event,
      attendees: attendees ?? this.attendees,
      isUserAttending: isUserAttending ?? this.isUserAttending,
      isLoadingAttendees: isLoadingAttendees ?? this.isLoadingAttendees,
      attendeeErrorMessage: attendeeErrorMessage ?? this.attendeeErrorMessage,
      showConfettiEffect: showConfettiEffect ?? this.showConfettiEffect,
    );
  }

  @override
  List<Object?> get props => [
    event,
    attendees,
    isUserAttending,
    isLoadingAttendees,
    attendeeErrorMessage,
    showConfettiEffect,
  ];
}

class ShereheDetailsError extends ShereheDetailsState {
  final String message;

  const ShereheDetailsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class MarkingAsGoing extends ShereheDetailsLoaded {
  const MarkingAsGoing({
    required super.event,
    required super.attendees,
    required super.isUserAttending,
  });
}

class MarkedAsGoingFailure extends ShereheDetailsLoaded {
  final String message;
  const MarkedAsGoingFailure({
    required super.event,
    required super.attendees,
    required super.isUserAttending,
    required this.message,
  });
}
