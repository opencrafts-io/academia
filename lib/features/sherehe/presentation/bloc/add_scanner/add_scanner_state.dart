part of 'add_scanner_bloc.dart';

abstract class AddScannerState extends Equatable {
  const AddScannerState();

  @override
  List<Object?> get props => [];
}

class AddScannerStateInitial extends AddScannerState {}

class AddScannerStateLoading extends AddScannerState {}

class AddScannerSuccess extends AddScannerState {
  final Scanner scanner;

  const AddScannerSuccess({required this.scanner});

  @override
  List<Object?> get props => [scanner];
}

class AddScannerStateError extends AddScannerState {
  final String message;

  const AddScannerStateError(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchUserLoading extends AddScannerState {}

class SearchUserSuccess extends AddScannerState {
  final List<ShereheUser> users;

  const SearchUserSuccess({required this.users});

  @override
  List<Object?> get props => [users];
}

class SearchUserFailure extends AddScannerState {
  final String message;

  const SearchUserFailure(this.message);

  @override
  List<Object?> get props => [message];
}
