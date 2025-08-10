part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final List<Event> events;
  final Map<String, List<Attendee>> attendeesMap;
  final bool hasReachedEnd;
  final int currentPage;

  const EventLoaded({
    required this.events,
    required this.attendeesMap,
    required this.hasReachedEnd,
    required this.currentPage,
  });

  @override
  List<Object> get props => [events, attendeesMap, hasReachedEnd, currentPage];
}

class EventError extends EventState {
  final String message;

  const EventError(this.message);

  @override
  List<Object> get props => [message];
}
