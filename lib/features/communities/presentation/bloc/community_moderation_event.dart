part of 'community_moderation_bloc.dart';

abstract class CommunityModerationEvent extends Equatable {
  const CommunityModerationEvent();

  @override
  List<Object?> get props => [];
}

class ModerateMembers extends CommunityModerationEvent {
  final String communityId;
  final String action;
  final String userId;

  const ModerateMembers({
    required this.communityId,
    required this.action,
    required this.userId,
  });

  @override
  List<Object?> get props => [communityId, action, userId];
}
