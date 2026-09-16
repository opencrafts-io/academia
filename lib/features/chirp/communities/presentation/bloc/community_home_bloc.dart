import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/communities/communities.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'community_home_state.dart';

part 'community_home_event.dart';

class CommunityHomeBloc extends Bloc<CommunityHomeEvent, CommunityHomeState> {
  final GetCommunityByIdUseCase getCommunityByIdUseCase;
  final DeleteCommunityUseCase deleteCommunityUseCase;
  final AddCommunityGuidelinesUsecase addCommunityGuidelinesUsecase;

  CommunityHomeBloc({
    required this.getCommunityByIdUseCase,
    required this.deleteCommunityUseCase,
    required this.addCommunityGuidelinesUsecase,
  }) : super(const CommunityHomeState.initial()) {
    on<FetchCommunityById>(_onFetchCommunityById);
    on<DeleteCommunity>(_onDeletingGroup);
    on<UpdateCommunity>(_onUpdateCommunity);
    on<AddCommunityGuidelines>(_onAddCommunityGuidelines);
  }

  Future<void> _onFetchCommunityById(
    FetchCommunityById event,
    Emitter<CommunityHomeState> emit,
  ) async {
    final Either<Failure, Community> result = await getCommunityByIdUseCase(
      event.communityId,
    );

    result.fold(
      (failure) => emit(CommunityHomeState.failure(failure.message)),
      (community) => emit(CommunityHomeState.loaded(community)),
    );
  }

  Future<void> _onDeletingGroup(
    DeleteCommunity event,
    Emitter<CommunityHomeState> emit,
  ) async {
    emit(const CommunityHomeState.loading());
    final result = await deleteCommunityUseCase(
      event.communityID,
    );

    result.fold(
      (failure) =>
          emit(CommunityHomeState.criticalActionFailure(failure.message)),
      (_) => emit(const CommunityHomeState.deleted()),
    );
  }

  Future<void> _onUpdateCommunity(
    UpdateCommunity event,
    Emitter<CommunityHomeState> emit,
  ) async {
    emit(CommunityHomeState.loaded(event.community));
  }

  Future<void> _onAddCommunityGuidelines(
    AddCommunityGuidelines event,
    Emitter<CommunityHomeState> emit,
  ) async {
    emit(const CommunityHomeState.loading());
    final result = await addCommunityGuidelinesUsecase(
      communityId: event.communityId,
      rule: event.rule,
      userId: event.userId,
    );

    result.fold(
      (failure) => emit(CommunityHomeState.failure(failure.message)),
      (community) => emit(CommunityHomeState.loaded(community)),
    );
  }
}
