part of 'community_users_bloc.dart';

abstract class CommunityUsersEvent extends Equatable {
  const CommunityUsersEvent();

  @override
  List<Object?> get props => [];
}

class FetchCommunityMembers extends CommunityUsersEvent {
  final String communityId;
  final int page;
  final UserType userType;

  const FetchCommunityMembers({
    required this.communityId,
    this.page = 1,
    required this.userType,
  });

  @override
  List<Object?> get props => [communityId, page];
}