import 'package:academia/features/chirp/domain/entities/chirp_user.dart';
import 'package:academia/features/communities/domain/entities/community.dart';
import 'package:academia/features/communities/domain/entities/community_moderation_enum.dart';
import 'package:academia/features/communities/domain/usecases/moderate_members_use_case.dart';
import 'package:academia/features/communities/domain/usecases/search_verisafe_users_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_members_event.dart';
part 'add_members_state.dart';

class AddMembersBloc extends Bloc<AddMembersEvent, AddMembersState> {
  final SearchVerisafeUsersUseCase searchUsers;
  final ModerateMembersUseCase moderateMembers;

  AddMembersBloc({required this.searchUsers, required this.moderateMembers})
    : super(AddMembersInitial()) {
    on<SearchUsers>(_onSearchUsers);
    on<AddMemberToCommunity>(_onAddMemberToCommunity);
  }

  Future<void> _onSearchUsers(
    SearchUsers event,
    Emitter<AddMembersState> emit,
  ) async {
    emit(AddMembersLoading());
    final result = await searchUsers.searchChirpUsers(event.query);

    result.fold(
      (failure) => emit(AddMembersFailure(failure.message)),
      (users) => emit(SearchResultsLoaded(users)),
    );
  }

  Future<void> _onAddMemberToCommunity(
    AddMemberToCommunity event,
    Emitter<AddMembersState> emit,
  ) async {
    emit(AddMembersLoading());
    final result = await moderateMembers(
      groupId: event.communityId,
      action: event.action.asApiString,
      userId: event.userId,
      memberId: event.memberId,
      memberName: event.memberName,
    );

    result.fold(
      (failure) => emit(AddMembersFailure(failure.message)),
      (community) => emit(MemberAddedSuccess(community)),
    );
  }
}
