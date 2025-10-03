import 'package:academia/features/communities/domain/entities/community_users_enum.dart';
import 'package:academia/features/communities/domain/entities/paginated_response.dart';
import 'package:academia/features/communities/domain/usecases/get_community_members_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'community_users_event.dart';
part 'community_users_state.dart';

class CommunityUsersBloc extends Bloc<CommunityUsersEvent, CommunityUsersState> {
  final GetCommunityMembersUsecase getCommunityMembersUsecase;

  CommunityUsersBloc({
    required this.getCommunityMembersUsecase,
  }) : super(CommunityUsersInitial()) {
    on<FetchCommunityMembers>(_onFetchCommunityMembers);
  }

  Future<void> _onFetchCommunityMembers(
    FetchCommunityMembers event,
    Emitter<CommunityUsersState> emit,
  ) async {
    emit(CommunityUsersLoading());

    final result =
        await getCommunityMembersUsecase(
      communityId: event.communityId,
      page: event.page,
      userType: event.userType.endpointPath,
    );

    result.fold(
      (failure) => emit(CommunityUsersFailure(failure.message)),
      (paginatedResponse) => emit(CommunityUsersLoaded(paginatedResponse)),
    );
  }
}
