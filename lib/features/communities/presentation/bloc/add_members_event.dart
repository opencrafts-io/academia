part of 'add_members_bloc.dart';

abstract class AddMembersEvent extends Equatable {
  const AddMembersEvent();

  @override
  List<Object?> get props => [];
}

class SearchUsers extends AddMembersEvent {
  final String query;

  const SearchUsers(this.query);

  @override
  List<Object?> get props => [query];
}

class AddMemberToCommunity extends AddMembersEvent {
  final String communityId;
  final CommunityModerationAction action;
  final String userId;
  final String memberId;
  final String memberName;

  const AddMemberToCommunity({
    required this.communityId,
    required this.action,
    required this.userId,
    required this.memberId,
    required this.memberName,
  });

  @override
  List<Object?> get props => [
    communityId,
    action,
    userId,
    memberId,
    memberName,
  ];
}
