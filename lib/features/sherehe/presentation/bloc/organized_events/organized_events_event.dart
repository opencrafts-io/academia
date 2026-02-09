part of 'organized_events_bloc.dart';


abstract class OrganizedEventsEvent extends Equatable {
  const OrganizedEventsEvent();

  @override
  List<Object?> get props => [];
}

class FetchOrganizedEvents extends OrganizedEventsEvent {
  final String organizerId;

  const FetchOrganizedEvents({required this.organizerId});
}
