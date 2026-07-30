import 'package:academia/features/chirp/communities/domain/entities/community_users_enum.dart';
import 'package:academia/features/chirp/communities/domain/usecases/get_community_members_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'community_users_state.dart';
export 'community_users_state.dart';

part 'community_users_event.dart';

class CommunityUsersBloc extends Bloc<CommunityUsersEvent, CommunityUsersState> {
  final GetCommunityMembersUsecase getCommunityMembersUsecase;

  CommunityUsersBloc({
    required this.getCommunityMembersUsecase,
  }) : super(const CommunityUsersState.initial()) {
    on<FetchCommunityMembers>(_onFetchCommunityMembers);
  }

  Future<void> _onFetchCommunityMembers(
    FetchCommunityMembers event,
    Emitter<CommunityUsersState> emit,
  ) async {
    emit(const CommunityUsersState.loading());

    final result =
        await getCommunityMembersUsecase(
      communityId: event.communityId,
      page: event.page,
      userType: event.userType.endpointPath,
    );

    result.fold(
      (failure) => emit(CommunityUsersState.failure(failure.message)),
      (paginatedResponse) =>
          emit(CommunityUsersState.loaded(paginatedResponse)),
    );
  }
}
