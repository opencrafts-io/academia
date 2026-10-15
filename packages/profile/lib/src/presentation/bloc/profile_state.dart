part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class ProfileInitialState extends ProfileState {
  const ProfileInitialState();

  @override
  bool? get stringify => true;
}

class ProfileLoadingstate extends ProfileState {
  const ProfileLoadingstate();

  @override
  bool? get stringify => true;
}

class ProfileLoadedState extends ProfileState {
  final UserProfile profile;
  const ProfileLoadedState({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class ProfileErrorState extends ProfileState {
  final String message;
  const ProfileErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class AccountDeletionRequestedState extends ProfileState {
  final String message;

  const AccountDeletionRequestedState({required this.message});

  @override
  List<Object> get props => [message];
}

class AccountRecoveryRequestedState extends ProfileState {
  final String message;

  const AccountRecoveryRequestedState({required this.message});

  @override
  List<Object> get props => [message];
}
