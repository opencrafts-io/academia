part of 'validate_attendee_bloc.dart';

abstract class ValidateAttendeeState extends Equatable {
  const ValidateAttendeeState();

  @override
  List<Object> get props => [];
}

class ValidateAttendeeInitial extends ValidateAttendeeState {}

class ValidateAttendeeLoading extends ValidateAttendeeState {}

class ValidateAttendeeLoaded extends ValidateAttendeeState {
  final String message;

  const ValidateAttendeeLoaded({required this.message});

  @override
  List<Object> get props => [message];
}

class ValidateAttendeeError extends ValidateAttendeeState {
  final String message;

  const ValidateAttendeeError({required this.message});

  @override
  List<Object> get props => [message];
}
