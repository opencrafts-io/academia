part of 'sherehe_home_bloc.dart';

abstract class ShereheHomeState extends Equatable {
  const ShereheHomeState();

  @override
  List<Object?> get props => [];
}

class EventInitial extends ShereheHomeState {}

class EventLoading extends ShereheHomeState {}

class EventLoaded extends ShereheHomeState {
  final List<Event> events;
  final bool hasMore;
  final int count;
  final int? nextPage;
  final int? previousPage;
  final Map<String, List<Attendee>> attendeesMap;

  const EventLoaded({
    required this.events,
    required this.hasMore,
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.attendeesMap,
  });

  EventLoaded copyWith({
    List<Event>? events,
    bool? hasMore,
    int? count,
    int? nextPage,
    int? previousPage,
    Map<String, List<Attendee>>? attendeesMap,
    Map<String, bool>? attendeesLoadingMap,
    Map<String, bool>? attendeesErrorMap,
  }) {
    return EventLoaded(
      events: events ?? this.events,
      hasMore: hasMore ?? this.hasMore,
      count: count ?? this.count,
      nextPage: nextPage ?? this.nextPage,
      previousPage: previousPage ?? this.previousPage,
      attendeesMap: attendeesMap ?? this.attendeesMap,
    );
  }

  @override
  List<Object?> get props => [
    events,
    hasMore,
    count,
    nextPage,
    previousPage,
    attendeesMap,
  ];
}

class EventsError extends ShereheHomeState {
  final String message;

  const EventsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class EventsPaginationLoading extends ShereheHomeState {
  final List<Event> existingEvents;
  final bool hasMore;

  const EventsPaginationLoading({
    required this.existingEvents,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [existingEvents, hasMore];
}

class EventsPaginationError extends ShereheHomeState {
  final List<Event> existingEvents;
  final String message;
  final bool hasMore;

  const EventsPaginationError({
    required this.existingEvents,
    required this.message,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [existingEvents, message, hasMore];
}
