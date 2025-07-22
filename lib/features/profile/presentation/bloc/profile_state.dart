part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class ProfileInitialState extends ProfileState {
  @override
  bool? get stringify => true;
}

class ProfileLoadingstate extends ProfileState {
  @override
  bool? get stringify => true;
}

class ProfileLoadedState extends ProfileState {
  final UserProfile profile;
  ProfileLoadedState({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class ProfileErrorState extends ProfileState {
  final String message;
  ProfileErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
