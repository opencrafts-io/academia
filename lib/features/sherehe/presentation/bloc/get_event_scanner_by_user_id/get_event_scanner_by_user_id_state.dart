part of 'get_event_scanner_by_user_id_bloc.dart';

abstract class GetEventScannerByUserIdState extends Equatable {
  const GetEventScannerByUserIdState();

  @override
  List<Object?> get props => [];
}

class GetEventScannerByUserIdStateInitial
    extends GetEventScannerByUserIdState {}

class GetEventScannerByUserIdStateLoading
    extends GetEventScannerByUserIdState {}

class GetEventScannerByUserIdSuccess extends GetEventScannerByUserIdState {
  final String message;

  const GetEventScannerByUserIdSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class GetEventScannerByUserIdStateError extends GetEventScannerByUserIdState {
  final String message;

  const GetEventScannerByUserIdStateError(this.message);

  @override
  List<Object?> get props => [message];
}
