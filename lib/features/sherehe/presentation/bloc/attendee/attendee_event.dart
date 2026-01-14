part of 'attendee_bloc.dart';

abstract class AttendeeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAttendees extends AttendeeEvent {
  final String eventId;

  FetchAttendees({required this.eventId});

  @override
  List<Object?> get props => [eventId];
}
