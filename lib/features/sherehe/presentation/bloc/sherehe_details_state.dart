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

  const ShereheDetailsLoaded({required this.event, required this.attendees});

  @override
  List<Object?> get props => [event, attendees];
}

class ShereheDetailsError extends ShereheDetailsState {
  final String message;

  const ShereheDetailsError({required this.message});

  @override
  List<Object?> get props => [message];
}