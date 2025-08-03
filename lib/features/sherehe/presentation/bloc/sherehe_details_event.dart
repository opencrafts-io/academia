part of 'sherehe_details_bloc.dart';

abstract class ShereheDetailsEvent extends Equatable {
  const ShereheDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadShereheDetails extends ShereheDetailsEvent {
  final int page;
  final int limit;
  final String eventId;

  const LoadShereheDetails({required this.eventId, this.page=1, this.limit=10});

  @override
  List<Object?> get props => [eventId];
}
