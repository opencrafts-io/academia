import 'package:academia/core/error/failures.dart';
import 'package:academia/features/communities/domain/entities/community.dart';
import 'package:academia/features/communities/domain/entities/community_moderation_enum.dart';
import 'package:academia/features/communities/domain/usecases/delete_community_use_case.dart';
import 'package:academia/features/communities/domain/usecases/get_community_by_id_use_case.dart';
import 'package:academia/features/communities/domain/usecases/join_community_use_case.dart';
import 'package:academia/features/communities/domain/usecases/leave_community_use_case.dart';
import 'package:academia/features/communities/domain/usecases/moderate_members_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'community_home_event.dart';
part 'community_home_state.dart';

class CommunityHomeBloc extends Bloc<CommunityHomeEvent, CommunityHomeState> {
  final GetCommunityByIdUseCase getCommunityByIdUseCase;
  final ModerateMembersUseCase moderateMembers;
  final JoinCommunityUseCase joinCommunityUseCase;
  final LeaveCommunityUseCase leaveCommunityUseCase;
  final DeleteCommunityUseCase deleteCommunityUseCase;

  CommunityHomeBloc({
    required this.getCommunityByIdUseCase,
    required this.moderateMembers,
    required this.joinCommunityUseCase,
    required this.leaveCommunityUseCase,
    required this.deleteCommunityUseCase,
  }) : super(CommunityHomeInitial()) {
    on<FetchCommunityById>(_onFetchCommunityById);
    on<ModerateMembers>(_onModerateCommunityMember);
    on<JoinCommunity>(_onJoiningGroup);
    on<LeaveCommunity>(_onLeavingGroup);
    on<DeleteCommunity>(_onDeletingGroup);
    on<UpdateCommunity>(_onUpdateCommunity);
  }

  Future<void> _onFetchCommunityById(
    FetchCommunityById event,
    Emitter<CommunityHomeState> emit,
  ) async {
    emit(CommunityHomeLoading());

    final Either<Failure, Community> result = await getCommunityByIdUseCase(
      event.communityId,
      event.userId,
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
      memberId: event.memberId,
      memberName: event.memberName,
    );

    result.fold(
      (failure) => emit(CommunityHomeFailure(failure.message)),
      (community) => emit(CommunityHomeLoaded(community)),
    );
  }

  Future<void> _onJoiningGroup(
    JoinCommunity event,
    Emitter<CommunityHomeState> emit,
  ) async {
    emit(CommunityHomeLoading());
    final result = await joinCommunityUseCase(
      event.communityId,
      event.userId,
      event.userName,
    );

    result.fold(
      (failure) => emit(CommunityHomeFailure(failure.message)),
      (community) => emit(CommunityHomeLoaded(community)),
    );
  }

  Future<void> _onLeavingGroup(
    LeaveCommunity event,
    Emitter<CommunityHomeState> emit,
  ) async {
    emit(CommunityHomeLoading());
    final result = await leaveCommunityUseCase(
      event.communityId,
      event.userId,
      event.userName,
    );

    result.fold(
      (failure) => emit(CommunityCriticalActionFailure(failure.message)),
      (_) => emit(CommunityLeft()),
    );
  }

  Future<void> _onDeletingGroup(
    DeleteCommunity event,
    Emitter<CommunityHomeState> emit,
  ) async {
    emit(CommunityHomeLoading());
    final result = await deleteCommunityUseCase(
      event.communityId,
      event.userId,
    );

    result.fold(
      (failure) => emit(CommunityCriticalActionFailure(failure.message)),
      (_) => emit(CommunityDeleted()),
    );
  }

  Future<void> _onUpdateCommunity(
    UpdateCommunity event,
    Emitter<CommunityHomeState> emit,
  ) async {
    emit(CommunityHomeLoaded(event.community));
  }
}
