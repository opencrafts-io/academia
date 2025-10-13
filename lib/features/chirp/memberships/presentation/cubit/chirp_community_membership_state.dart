part of 'chirp_community_membership_cubit.dart';

sealed class ChirpCommunityMembershipState extends Equatable {
  @override
  bool? get stringify => true;
  @override
  List<Object?> get props => [];
}

class ChirpCommunityMembershipInitialState
    extends ChirpCommunityMembershipState {}

class ChirpCommunityMembershipCommunityLeftState
    extends ChirpCommunityMembershipState {
  final int communityID;

  ChirpCommunityMembershipCommunityLeftState({required this.communityID});

  @override
  List<Object?> get props => [communityID];
}

class ChirpCommunityMembershipStateLoadingState
    extends ChirpCommunityMembershipState {
  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [];
}

class ChirpCommunityMembershipLoadedState
    extends ChirpCommunityMembershipState {
  final ChirpCommunityMembership membership;

  ChirpCommunityMembershipLoadedState({required this.membership});
  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [membership];
}

class ChirpCommunityMembershipErrorState extends ChirpCommunityMembershipState {
  final String error;
  ChirpCommunityMembershipErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}
