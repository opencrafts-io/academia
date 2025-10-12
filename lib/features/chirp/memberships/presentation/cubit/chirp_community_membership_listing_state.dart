part of 'chirp_community_membership_listing_cubit.dart';

class ChirpCommunityMembershipListingState extends Equatable {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class ChirpCommunityMembershipListingInitialState
    extends ChirpCommunityMembershipListingState {}

class ChirpCommunityMembershipListingLoadingState
    extends ChirpCommunityMembershipListingState {}

class ChirpCommunityMembershipListingErrorState
    extends ChirpCommunityMembershipListingState {
  final String error;
  ChirpCommunityMembershipListingErrorState({required this.error});
}

class ChirpCommunityMembershipListingLoadedState
    extends ChirpCommunityMembershipListingState {
  final bool isLoading;
  final bool hasReachedMax;
  final List<ChirpCommunityMembership> memberships;

  ChirpCommunityMembershipListingLoadedState({
    required this.memberships,
    this.isLoading = false,
    this.hasReachedMax = true,
  });

  ChirpCommunityMembershipListingLoadedState copyWith({
    bool? isLoading,
    bool? hasReachedMax,
    List<ChirpCommunityMembership>? memberships,
  }) {
     this.memberships.addAll(memberships ?? []);
    final updatedList = this.memberships.toSet().toList();

    return ChirpCommunityMembershipListingLoadedState(
      memberships: updatedList,
      isLoading: isLoading ?? this.isLoading,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [hasReachedMax, isLoading, memberships];
}
