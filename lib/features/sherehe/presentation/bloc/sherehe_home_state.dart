part of 'sherehe_home_bloc.dart';

abstract class ShereheHomeState extends Equatable {
  const ShereheHomeState();

  @override
  List<Object> get props => [];
}

class EventInitial extends ShereheHomeState {}

class EventLoading extends ShereheHomeState {}

class EventLoaded extends ShereheHomeState {
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

class EventError extends ShereheHomeState {
  final String message;

  const EventError(this.message);

  @override
  List<Object> get props => [message];
}
