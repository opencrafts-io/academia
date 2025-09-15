part of 'magnet_bloc.dart';

sealed class MagnetState extends Equatable {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class MagnetInitialState extends MagnetState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class MagnetLoadingState extends MagnetState {}

class MagnetAuthenticatedState extends MagnetState {}

class MagnetCredentialFetched extends MagnetState {
  final MagnetCredential magnetCredential;
  MagnetCredentialFetched({required this.magnetCredential});

  @override
  List<Object?> get props => [magnetCredential];
}

class MagnetCredentialNotFetched extends MagnetState {
  final String error;
  MagnetCredentialNotFetched({required this.error});

  @override
  List<Object?> get props => [error];

  @override
  bool? get stringify => true;
}

class MagnetNotSupportedState extends MagnetState {}

class MagnetErrorState extends MagnetState {
  final String error;
  MagnetErrorState({required this.error});

  @override
  List<Object?> get props => [error];

  @override
  bool? get stringify => true;
}

class MagnetInstancesLoadedState extends MagnetState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}
