part of 'get_event_scanner_by_user_id_bloc.dart';

abstract class GetEventScannerByUserIdEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetEventScannerByUserId extends GetEventScannerByUserIdEvent {
  final String eventId;

  GetEventScannerByUserId({required this.eventId});

  @override
  List<Object?> get props => [eventId];
}
