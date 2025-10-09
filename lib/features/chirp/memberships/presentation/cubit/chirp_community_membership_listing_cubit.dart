import 'package:academia/features/chirp/memberships/memberships.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chirp_community_membership_listing_state.dart';

class ChirpCommunityMembershipListingCubit
    extends Cubit<ChirpCommunityMembershipListingState> {
  ChirpCommunityMembershipListingCubit({
    required this.getCommunityMembershipsUsecase,
  }) : super(ChirpCommunityMembershipListingInitialState());

  final GetCommunityMembershipsUsecase getCommunityMembershipsUsecase;

  final int pageSize = 100;
  int page = 1;
  bool isLoading = false;

  Future<void> getCommunityMembers({required int communityID, page = 1}) async {
    if (isLoading) return;

    isLoading = true;
    emit(ChirpCommunityMembershipListingLoadingState());

    final result = await getCommunityMembershipsUsecase(
      GetCommunityMembershipsUsecaseParams(
        page: page,
        communityID: communityID,
        pageSize: pageSize,
      ),
    );

    result.fold(
      (failure) {
        emit(ChirpCommunityMembershipListingErrorState(error: failure.message));
        isLoading = false;
      },
      (memberships) {
        if (state is ChirpCommunityMembershipListingLoadedState) {
          final currentState =
              state as ChirpCommunityMembershipListingLoadedState;
          bool hasReachedMax = false;

          if (memberships.length < pageSize) {
            hasReachedMax = true;
          }
          emit(
            currentState.copyWith(
              memberships: memberships,
              hasReachedMax: hasReachedMax,
              isLoading: false,
            ),
          );
        } else {
          emit(
            ChirpCommunityMembershipListingLoadedState(
              memberships: memberships,
              hasReachedMax: memberships.length < pageSize,
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
