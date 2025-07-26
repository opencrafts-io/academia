part of 'sherehe_details_bloc.dart';

abstract class ShereheDetailsEvent extends Equatable {
  const ShereheDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadShereheDetails extends ShereheDetailsEvent {
  final String eventId;

  const LoadShereheDetails({required this.eventId});

  @override
  List<Object?> get props => [eventId];
}