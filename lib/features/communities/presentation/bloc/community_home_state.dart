part of 'community_home_bloc.dart';

abstract class CommunityHomeState extends Equatable {
  const CommunityHomeState();

  @override
  List<Object?> get props => [];
}

class CommunityHomeInitial extends CommunityHomeState {}

class CommunityHomeLoading extends CommunityHomeState {}

class CommunityHomeLoaded extends CommunityHomeState {
  final Community community;

  const CommunityHomeLoaded(this.community);

  @override
  List<Object?> get props => [community];
}

class CommunityLeft extends CommunityHomeState {}

class CommunityDeleted extends CommunityHomeState {}

class CommunityHomeFailure extends CommunityHomeState {
  final String message;

  const CommunityHomeFailure(this.message);

  @override
  List<Object?> get props => [message];
}
