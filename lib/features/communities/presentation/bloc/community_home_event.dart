part of 'community_home_bloc.dart';

abstract class CommunityHomeEvent extends Equatable {
  const CommunityHomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchCommunityById extends CommunityHomeEvent {
  final String communityId;

  const FetchCommunityById({required this.communityId});

  @override
  List<Object?> get props => [communityId];
}

class UpdateCommunity extends CommunityHomeEvent {
  final Community community;

  const UpdateCommunity({required this.community});

  @override
  List<Object?> get props => [community];
} 

class JoinCommunity extends CommunityHomeEvent {
  final String communityId;

  const JoinCommunity({required this.communityId});

  @override
  List<Object?> get props => [communityId];
}

class LeaveCommunity extends CommunityHomeEvent {
  final String communityId;

  const LeaveCommunity({required this.communityId});

  @override
  List<Object?> get props => [communityId];
} 

class DeleteCommunity extends CommunityHomeEvent {
  final String communityId;
  final String userId;

  const DeleteCommunity({required this.communityId, required this.userId});

  @override
  List<Object?> get props => [communityId];
} 

class ModerateMembers extends CommunityHomeEvent {
  final String communityId;
  final CommunityModerationAction action;
  final String userId;

  const ModerateMembers({
    required this.communityId,
    required this.action,
    required this.userId,
  });

  @override
  List<Object?> get props => [communityId, action, userId];
}
