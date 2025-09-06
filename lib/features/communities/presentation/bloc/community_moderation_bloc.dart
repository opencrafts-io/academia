import 'package:academia/core/error/failures.dart';
import 'package:academia/features/communities/domain/entities/community.dart';
import 'package:academia/features/communities/domain/usecases/moderate_members_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'community_moderation_event.dart';
part 'community_moderation_state.dart';

class CommunityModerationBloc
    extends Bloc<CommunityModerationEvent, CommunityModerationState> {
  final ModerateMembersUseCase moderateMembersUseCase;

  CommunityModerationBloc({required this.moderateMembersUseCase})
    : super(InitialState()) {
    on<ModerateMembers>(_onModerateMembers);
  }

  Future<void> _onModerateMembers(
    ModerateMembers event,
    Emitter<CommunityModerationState> emit,
  ) async {
    emit(LoadingState());

    final Either<Failure, Community> result = await moderateMembersUseCase(
      groupId: event.communityId,
      action: event.action,
      userId: event.userId,
    );

    result.fold(
      (failure) => emit(FailureState(failure.message)),
      (community) => emit(CommunityModeratedLoaded(community)),
    );
  }
}
