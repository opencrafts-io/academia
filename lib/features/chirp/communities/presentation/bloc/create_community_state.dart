part of 'create_community_bloc.dart';

abstract class CreateCommunityState extends Equatable {
  const CreateCommunityState();

  @override
  List<Object?> get props => [];
}

class CreateCommunityInitial extends CreateCommunityState {}

class CreateCommunityLoading extends CreateCommunityState {}

class CreateCommunitySuccess extends CreateCommunityState {
  final Community community;
  const CreateCommunitySuccess({required this.community});

  @override
  List<Object?> get props => [community];
}

class CreateCommunityFailure extends CreateCommunityState {
  final String message;
  const CreateCommunityFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
