part of 'sherehe_home_bloc.dart';

abstract class ShereheHomeEvent extends Equatable {
  const ShereheHomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllEvents extends ShereheHomeEvent {
  final int limit;
  final String? eventId;
  final bool isLoadMore;

  const FetchAllEvents({this.eventId, this.limit = 10, this.isLoadMore = false,});
}
