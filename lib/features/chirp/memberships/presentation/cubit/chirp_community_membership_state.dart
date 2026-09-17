import 'package:academia/features/chirp/memberships/domain/entities/chirp_community_membership.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chirp_community_membership_state.freezed.dart';

@freezed
sealed class ChirpCommunityMembershipState
    with _$ChirpCommunityMembershipState {
  const factory ChirpCommunityMembershipState.initial() =
      ChirpCommunityMembershipInitialState;
  const factory ChirpCommunityMembershipState.communityLeft({
    required int communityID,
  }) = ChirpCommunityMembershipCommunityLeftState;
  const factory ChirpCommunityMembershipState.loading() =
      ChirpCommunityMembershipStateLoadingState;
  const factory ChirpCommunityMembershipState.loaded({
    required ChirpCommunityMembership membership,
  }) = ChirpCommunityMembershipLoadedState;
  const factory ChirpCommunityMembershipState.error({required String error}) =
      ChirpCommunityMembershipErrorState;
}
