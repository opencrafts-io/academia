part of 'sherehe_details_bloc.dart';

abstract class ShereheDetailsEvent extends Equatable {
  const ShereheDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadShereheDetails extends ShereheDetailsEvent {
  final String eventId;
  final Event? initialEvent;

  const LoadShereheDetails({required this.eventId, this.initialEvent});

  @override
  List<Object?> get props => [eventId, initialEvent];
}
