part of 'community_moderation_bloc.dart';

abstract class CommunityModerationState extends Equatable {
  const CommunityModerationState();

  @override
  List<Object?> get props => [];
}

class InitialState extends CommunityModerationState {}

class LoadingState extends CommunityModerationState {}


class CommunityModeratedLoading extends CommunityModerationState {}

class CommunityModeratedLoaded extends CommunityModerationState {
  final Community community;

  const CommunityModeratedLoaded(this.community);

  @override
  List<Object?> get props => [community];
} 

class FailureState extends CommunityModerationState {
  final String message;

  const FailureState(this.message);

  @override
  List<Object?> get props => [message];
}
