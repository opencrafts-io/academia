part of 'scanner_actions_bloc.dart';

abstract class ScannerActionsState extends Equatable {
  const ScannerActionsState();

  @override
  List<Object?> get props => [];
}

class ScannerActionsStateInitial extends ScannerActionsState {}

class AddScannerStateLoading extends ScannerActionsState {}

class AddScannerSuccess extends ScannerActionsState {
  final Scanner scanner;

  const AddScannerSuccess({required this.scanner});

  @override
  List<Object?> get props => [scanner];
}

class AddScannerStateError extends ScannerActionsState {
  final String message;

  const AddScannerStateError(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteScannerLoading extends ScannerActionsState {}

class DeleteScannerSuccess extends ScannerActionsState {
  final String message;

  const DeleteScannerSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class DeleteScannerError extends ScannerActionsState {
  final String message;

  const DeleteScannerError(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchUserLoading extends ScannerActionsState {}

class SearchUserSuccess extends ScannerActionsState {
  final List<ShereheUser> users;

  const SearchUserSuccess({required this.users});

  @override
  List<Object?> get props => [users];
}

class SearchUserFailure extends ScannerActionsState {
  final String message;

  const SearchUserFailure(this.message);

  @override
  List<Object?> get props => [message];
}
