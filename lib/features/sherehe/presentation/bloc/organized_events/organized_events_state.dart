part of 'organized_events_bloc.dart';

abstract class OrganizedEventsState extends Equatable {
  const OrganizedEventsState();

  @override
  List<Object?> get props => [];
}

class OrganizedEventsInitial extends OrganizedEventsState {}

class OrganizedEventsLoading extends OrganizedEventsState {}

class OrganizedEventsLoaded extends OrganizedEventsState {
  final List<Event> events;

  const OrganizedEventsLoaded({required this.events});

  @override
  List<Object?> get props => [events];
}

class OrganizedEventsError extends OrganizedEventsState {
  final String message;

  const OrganizedEventsError({required this.message});

  @override
  List<Object?> get props => [message];
}
