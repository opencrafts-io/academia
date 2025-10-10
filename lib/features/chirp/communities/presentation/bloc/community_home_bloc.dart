import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/communities/communities.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'community_home_event.dart';
part 'community_home_state.dart';

class CommunityHomeBloc extends Bloc<CommunityHomeEvent, CommunityHomeState> {
  final GetCommunityByIdUseCase getCommunityByIdUseCase;
  final DeleteCommunityUseCase deleteCommunityUseCase;
  final AddCommunityGuidelinesUsecase addCommunityGuidelinesUsecase;

  CommunityHomeBloc({
    required this.getCommunityByIdUseCase,
    required this.deleteCommunityUseCase,
    required this.addCommunityGuidelinesUsecase,
  }) : super(CommunityHomeInitial()) {
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
      (failure) => emit(CommunityHomeFailure(failure.message)),
      (community) => emit(CommunityHomeLoaded(community)),
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

  Future<void> _onAddCommunityGuidelines(
    AddCommunityGuidelines event,
    Emitter<CommunityHomeState> emit,
  ) async {
    emit(CommunityHomeLoading());
    final result = await addCommunityGuidelinesUsecase(
      communityId: event.communityId,
      rule: event.rule,
      userId: event.userId,
    );

    result.fold(
      (failure) => emit(CommunityHomeFailure(failure.message)),
      (community) => emit(CommunityHomeLoaded(community)),
    );
  }
}
