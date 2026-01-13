part of 'validate_attendee_bloc.dart';

abstract class ValidateAttendeeEvent extends Equatable {
  const ValidateAttendeeEvent();

  @override
  List<Object> get props => [];
}

class ValidateAttendee extends ValidateAttendeeEvent {
  final String eventId;
  final String attendeeId;

  const ValidateAttendee({required this.eventId, required this.attendeeId});

  @override
  List<Object> get props => [eventId, attendeeId];
}
