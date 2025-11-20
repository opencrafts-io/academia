part of 'sherehe_home_bloc.dart';

abstract class ShereheHomeEvent extends Equatable {
  const ShereheHomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllEvents extends ShereheHomeEvent {
  final int page;
  final int limit;
  final bool isLoadMore;

  const FetchAllEvents({
    required this.page,
    this.limit = 10,
    this.isLoadMore = false,
  });
}

class FetchEventAttendees extends ShereheHomeEvent {
  final Event event;

  const FetchEventAttendees({required this.event});
}
