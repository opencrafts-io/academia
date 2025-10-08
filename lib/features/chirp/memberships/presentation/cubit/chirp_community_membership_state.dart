part of 'chirp_community_membership_cubit.dart';

sealed class ChirpCommunityMembershipState extends Equatable {
  @override
  bool? get stringify => true;
  @override
  List<Object?> get props => [];
}

class ChirpCommunityMembershipInitialState
    extends ChirpCommunityMembershipState {}

class ChirpCommunityMembershipStateLoadingState
    extends ChirpCommunityMembershipState {
  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [];
}

class ChirpCommunityMembershipStateLoadedState
    extends ChirpCommunityMembershipState {
  final bool hasMore;
  // final List<ChirpCommunityMembership> memberships;

  ChirpCommunityMembershipStateLoadedState({
    this.hasMore = true,
    // required this.memberships,
  });
  @override
  bool? get stringify => true;

  // @override
  // List<Object?> get props => [hasMore, memberships];
}

class ChirpCommunityMembershipErrorState extends ChirpCommunityMembershipState {
  final String error;
  ChirpCommunityMembershipErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}
