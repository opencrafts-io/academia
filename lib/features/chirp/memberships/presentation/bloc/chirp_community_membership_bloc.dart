import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/memberships/memberships.dart';
import 'package:academia/features/communities/communities.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chirp_community_membership_state.dart';
part 'chirp_community_membership_events.dart';

class ChirpCommunityMembershipBloc
    extends Bloc<ChirpCommunityMembershipEvent, ChirpCommunityMembershipState> {
  // Usecases
  final GetCachedPersonalChirpCommunityMemberships
  getCachedPersonalChirpCommunityMemberships;

  final GetRemotePersonalChirpMembershipsUsecase
  getRemotePersonalChirpMembershipsUsecase;

  ChirpCommunityMembershipBloc({
    required this.getCachedPersonalChirpCommunityMemberships,
    required this.getRemotePersonalChirpMembershipsUsecase,
  }) : super(ChirpCommunityMembershipStateLoadingState()) {
    // Event handler for loading previously cached memberships
    on<GetCachedChirpCommunityMembershipEvent>((event, emit) async {
      emit(ChirpCommunityMembershipStateLoadingState());
      final result = await getCachedPersonalChirpCommunityMemberships(
        NoParams(),
      );
      return result.fold(
        (failure) =>
            emit(ChirpCommunityMembershipErrorState(error: failure.message)),
        (memberships) => emit(
          ChirpCommunityMembershipStateLoadedState(memberships: memberships),
        ),
      );
    });

    // Event handler for refreshing cached
    on<GetRemotePersonalChirpCommunityMembershipEvent>((event, emit) async {
      emit(ChirpCommunityMembershipStateLoadingState());
      final result = await getRemotePersonalChirpMembershipsUsecase(
        GetRemotePersonalChirpMembershipsUsecaseParams(
          page: event.page,
          pageSize: event.pageSize,
        ),
      );
      return result.fold(
        (failure) =>
            emit(ChirpCommunityMembershipErrorState(error: failure.message)),
        (memberships) {
          if (state is CommunitiesLoadedState && memberships.isEmpty) {
            return emit(
              ChirpCommunityMembershipStateLoadedState(
                memberships: memberships,
                hasMore: false,
              ),
            );
          }
          return emit(
            ChirpCommunityMembershipStateLoadedState(
              memberships: memberships,
              hasMore: true,
            ),
          );
        },
      );
    });
  }
}
