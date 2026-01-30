part of 'attendees_and_scanner_stats_bloc.dart';

abstract class AttendeesAndScannerStatsEvent extends Equatable {
  const AttendeesAndScannerStatsEvent();

  @override
  List<Object> get props => [];
}

class GetAttendeesAndScanners extends AttendeesAndScannerStatsEvent {
  final String eventId;

  const GetAttendeesAndScanners({required this.eventId});

  @override
  List<Object> get props => [eventId];
}
