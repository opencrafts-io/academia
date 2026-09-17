import 'package:academia/features/chirp/memberships/domain/entities/chirp_community_membership.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chirp_community_membership_listing_state.freezed.dart';

@freezed
sealed class ChirpCommunityMembershipListingState
    with _$ChirpCommunityMembershipListingState {
  const factory ChirpCommunityMembershipListingState.initial() =
      ChirpCommunityMembershipListingInitialState;
  const factory ChirpCommunityMembershipListingState.loading() =
      ChirpCommunityMembershipListingLoadingState;
  const factory ChirpCommunityMembershipListingState.error({
    required String error,
  }) = ChirpCommunityMembershipListingErrorState;
  const factory ChirpCommunityMembershipListingState.loaded({
    required List<ChirpCommunityMembership> memberships,
    @Default(false) bool isLoading,
    @Default(true) bool hasReachedMax,
  }) = ChirpCommunityMembershipListingLoadedState;
}
