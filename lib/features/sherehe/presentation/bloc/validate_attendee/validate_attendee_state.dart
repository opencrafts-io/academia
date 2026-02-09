part of 'validate_attendee_bloc.dart';

abstract class ValidateAttendeeState extends Equatable {
  const ValidateAttendeeState();

  @override
  List<Object> get props => [];
}

class ValidateAttendeeInitial extends ValidateAttendeeState {}

class ValidateAttendeeLoading extends ValidateAttendeeState {}

class ValidateAttendeeLoaded extends ValidateAttendeeState {
  final String status;

  const ValidateAttendeeLoaded({required this.status});

  @override
  List<Object> get props => [status];
}

class ValidateAttendeeError extends ValidateAttendeeState {
  final String message;

  const ValidateAttendeeError({required this.message});

  @override
  List<Object> get props => [message];
}
