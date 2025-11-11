part of 'sherehe_details_bloc.dart';

abstract class ShereheDetailsEvent extends Equatable {
  const ShereheDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadShereheDetails extends ShereheDetailsEvent {
  final String eventId;

  const LoadShereheDetails({required this.eventId});

  @override
  List<Object> get props => [eventId];
}

class MarkAsGoing extends ShereheDetailsEvent {
  final String eventId;
  final String userId;

  const MarkAsGoing({required this.eventId, required this.userId});

  @override
  List<Object> get props => [eventId, userId];
}
