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

class ProfileLoadedState extends ProfileState {}
