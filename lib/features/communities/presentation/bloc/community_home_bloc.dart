import 'package:academia/core/error/failures.dart';
import 'package:academia/features/communities/domain/entities/community.dart';
import 'package:academia/features/communities/domain/entities/community_moderation_enum.dart';
import 'package:academia/features/communities/domain/usecases/get_community_by_id_use_case.dart';
import 'package:academia/features/communities/domain/usecases/moderate_members_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'community_home_event.dart';
part 'community_home_state.dart';

class CommunityHomeBloc extends Bloc<CommunityHomeEvent, CommunityHomeState> {
  final GetCommunityByIdUseCase getCommunityByIdUseCase;
  final ModerateMembersUseCase moderateMembers;

  CommunityHomeBloc({
    required this.getCommunityByIdUseCase,
    required this.moderateMembers,
  }) : super(CommunityHomeInitial()) {
    on<FetchCommunityById>(_onFetchCommunityById);
    on<ModerateMembers>(_onModerateCommunityMember);
    on<UpdateCommunity>(_onUpdateCommunity);
  }

  Future<void> _onFetchCommunityById(
    FetchCommunityById event,
    Emitter<CommunityHomeState> emit,
  ) async {
    emit(CommunityHomeLoading());

    final Either<Failure, Community> result = await getCommunityByIdUseCase(
      event.communityId,
    );

    result.fold(
      (failure) => emit(CommunityHomeFailure(failure.message)),
      (community) => emit(CommunityHomeLoaded(community)),
    );
  }

  Future<void> _onModerateCommunityMember(
    ModerateMembers event,
    Emitter<CommunityHomeState> emit,
  ) async {
    emit(CommunityHomeLoading());
    final result = await moderateMembers(
      groupId: event.communityId,
      action: event.action.asApiString,
      userId: event.userId,
    );

    result.fold(
      (failure) => emit(CommunityHomeFailure(failure.message)),
      (community) => emit(CommunityHomeLoaded(community)),
    );
  }

  Future<void> _onUpdateCommunity(
    UpdateCommunity event,
    Emitter<CommunityHomeState> emit,
  ) async {
    emit(CommunityHomeLoaded(event.community));
  }
}
