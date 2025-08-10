part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllEvents extends EventEvent {
  final int limit;
  final String? eventId;
  final bool isLoadMore;

  const FetchAllEvents({this.eventId, this.limit = 10, this.isLoadMore = false,});
}
