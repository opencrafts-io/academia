part of 'community_home_bloc.dart';


abstract class CommunityHomeEvent extends Equatable {
  const CommunityHomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchCommunityById extends CommunityHomeEvent {
  final int communityId;

  const FetchCommunityById({required this.communityId});

  @override
  List<Object?> get props => [communityId];
}

class FetchCachedCommunityById extends CommunityHomeEvent {
  final int communityId;

  const FetchCachedCommunityById({required this.communityId});

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
  final String userId;
  final String userName;

  const JoinCommunity({
    required this.communityId,
    required this.userId,
    required this.userName,
  });

  @override
  List<Object?> get props => [communityId];
}

class LeaveCommunity extends CommunityHomeEvent {
  final String communityId;
  final String userId;
  final String userName;

  const LeaveCommunity({
    required this.communityId,
    required this.userId,
    required this.userName,
  });

  @override
  List<Object?> get props => [communityId, userId, userName];
}

class DeleteCommunity extends CommunityHomeEvent {
  final String communityId;
  final String userId;

  const DeleteCommunity({required this.communityId, required this.userId});

  @override
  List<Object?> get props => [communityId];
}

// class ModerateMembers extends CommunityHomeEvent {
//   final String communityId;
//   final CommunityModerationAction action;
//   final String userId;
//   final String memberId;
//   final String memberName;
//
//   const ModerateMembers({
//     required this.communityId,
//     required this.action,
//     required this.userId,
//     required this.memberId,
//     required this.memberName,
//   });
//
//   @override
//   List<Object?> get props => [
//     communityId,
//     action,
//     userId,
//     memberId,
//     memberName,
//   ];
// }

class AddCommunityGuidelines extends CommunityHomeEvent {
  final List<String> rule;
  final String communityId;
  final String userId;

  const AddCommunityGuidelines({
    required this.rule,
    required this.communityId,
    required this.userId,
  });

  @override
  List<Object?> get props => [
    rule,
    communityId,
    userId,
  ];
}
