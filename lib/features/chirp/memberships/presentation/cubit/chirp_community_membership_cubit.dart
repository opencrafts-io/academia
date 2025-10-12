import 'package:academia/features/chirp/memberships/memberships.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'chirp_community_membership_state.dart';

class ChirpCommunityMembershipCubit
    extends Cubit<ChirpCommunityMembershipState> {
  // Usecases
  JoinCommunityUsecase joinCommunityUsecase;
  LeaveCommunityUsecase leaveCommunityUsecase;
  GetPersonalCommunityMembershipForCommunityUsecase
  getPersonalCommunityMembershipForCommunityUsecase;

  ChirpCommunityMembershipCubit({
    required this.joinCommunityUsecase,
    required this.leaveCommunityUsecase,
    required this.getPersonalCommunityMembershipForCommunityUsecase,
  }) : super(ChirpCommunityMembershipInitialState());

  Future<void> getPersonalCommunityMembershipForCommunity({
    required int communityID,
    required String userID,
  }) async {
    final result = await getPersonalCommunityMembershipForCommunityUsecase(
      GetPersonalCommunityMembershipForCommunityUsecaseParams(
        communityID: communityID,
        userID: userID,
      ),
    );

    result.fold(
      (failure) {
        emit(ChirpCommunityMembershipErrorState(error: failure.message));
      },
      (membership) {
        emit(ChirpCommunityMembershipLoadedState(membership: membership));
      },
    );
  }

  Future<void> joinCommunity({required int communityID}) async {
    final result = await joinCommunityUsecase(communityID);

    result.fold(
      (failure) =>
          emit(ChirpCommunityMembershipErrorState(error: failure.message)),
      (communityMembership) {
        emit(
          ChirpCommunityMembershipLoadedState(membership: communityMembership),
        );
      },
    );
  }

  Future<void> leaveCommunity({required int communityID}) async {
    final result = await leaveCommunityUsecase(communityID);

    result.fold(
      (failure) {
        emit(ChirpCommunityMembershipErrorState(error: failure.message));
      },
      (ok) {
        emit(
          ChirpCommunityMembershipCommunityLeftState(communityID: communityID),
        );
      },
    );
  }
}
