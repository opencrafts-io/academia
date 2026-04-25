part of 'sherehe_details_bloc.dart';

abstract class ShereheDetailsEvent extends Equatable {
  const ShereheDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadShereheDetails extends ShereheDetailsEvent {
  final String? eventId;
  final Event? initialEvent;
  final String? invite;

  const LoadShereheDetails({this.eventId, this.initialEvent, this.invite});

  @override
  List<Object?> get props => [eventId, initialEvent, invite];
}
