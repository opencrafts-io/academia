part of 'add_scanner_bloc.dart';

abstract class AddScannerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddScanner extends AddScannerEvent {
  final String eventId;
  final String userId;

  AddScanner({required this.eventId, required this.userId});

  @override
  List<Object?> get props => [eventId, userId];
}

class SearchUser extends AddScannerEvent {
  final String query;

  SearchUser({required this.query});

  @override
  List<Object?> get props => [query];
}
