part of 'attendee_bloc.dart';

abstract class AttendeeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AttendeeInitial extends AttendeeState {}

class AttendeeLoading extends AttendeeState {}

class AttendeeLoaded extends AttendeeState {
  final List<Attendee> attendees;

  AttendeeLoaded({required this.attendees});

  @override
  List<Object?> get props => [attendees];
}

class AttendeeError extends AttendeeState {
  final String message;

  AttendeeError(this.message);

  @override
  List<Object?> get props => [message];
}
