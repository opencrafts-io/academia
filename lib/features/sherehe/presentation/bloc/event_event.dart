part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllEvents extends EventEvent {
  final int page;
  final int limit;
  final String? eventId;

  const FetchAllEvents({this.eventId, this.page = 1, this.limit = 10});
}
