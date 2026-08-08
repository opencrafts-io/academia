import 'package:academia/features/chirp/memberships/memberships.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'chirp_community_membership_listing_state.dart';

class ChirpCommunityMembershipListingCubit
    extends Cubit<ChirpCommunityMembershipListingState> {
  ChirpCommunityMembershipListingCubit({
    required this.getCommunityMembershipsUsecase,
  }) : super(const ChirpCommunityMembershipListingState.initial());

  final GetCommunityMembershipsUsecase getCommunityMembershipsUsecase;

  final int pageSize = 100;
  int page = 1;
  bool isLoading = false;

  Future<void> getCommunityMembers({required int communityID, page = 1}) async {
    if (isLoading) return;

    isLoading = true;
    emit(const ChirpCommunityMembershipListingState.loading());

    final result = await getCommunityMembershipsUsecase(
      GetCommunityMembershipsUsecaseParams(
        page: page,
        communityID: communityID,
        pageSize: pageSize,
      ),
    );

    result.fold(
      (failure) {
        emit(
          ChirpCommunityMembershipListingState.error(error: failure.message),
        );
        isLoading = false;
      },
      (memberships) {
        final currentState = state;
        final hasReachedMax = memberships.length < pageSize;

        if (currentState is ChirpCommunityMembershipListingLoadedState) {
          final updatedList = {
            ...currentState.memberships,
            ...memberships,
          }.toList();

          emit(
            ChirpCommunityMembershipListingState.loaded(
              memberships: updatedList,
              hasReachedMax: hasReachedMax,
              isLoading: false,
            ),
          );
        } else {
          emit(
            ChirpCommunityMembershipListingState.loaded(
              memberships: memberships,
              hasReachedMax: hasReachedMax,
              isLoading: false,
            ),
          );
        }

        page++;
        isLoading = false;
      },
    );
  }
}
