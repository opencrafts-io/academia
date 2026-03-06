part of 'scanner_actions_bloc.dart';

abstract class ScannerActionsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddScanner extends ScannerActionsEvent {
  final String eventId;
  final String userId;

  AddScanner({required this.eventId, required this.userId});

  @override
  List<Object?> get props => [eventId, userId];
}

class DeleteScanner extends ScannerActionsEvent {
  final String scannerId;

  DeleteScanner({required this.scannerId});

  @override
  List<Object?> get props => [scannerId];
}

class SearchUser extends ScannerActionsEvent {
  final String query;

  SearchUser({required this.query});

  @override
  List<Object?> get props => [query];
}
