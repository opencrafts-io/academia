import 'package:academia/core/error/failures.dart';
import 'package:academia/features/communities/domain/entities/community.dart';
import 'package:academia/features/communities/domain/usecases/get_community_by_id_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'community_home_event.dart';
part 'community_home_state.dart';

class CommunityHomeBloc extends Bloc<CommunityHomeEvent, CommunityHomeState> {
  final GetCommunityByIdUseCase getCommunityByIdUseCase;

  CommunityHomeBloc({required this.getCommunityByIdUseCase})
      : super(CommunityHomeInitial()) {
    on<FetchCommunityById>(_onFetchCommunityById);
  }

  Future<void> _onFetchCommunityById(
    FetchCommunityById event,
    Emitter<CommunityHomeState> emit,
  ) async {
    emit(CommunityHomeLoading());

    final Either<Failure, Community> result =
        await getCommunityByIdUseCase(event.communityId);

    result.fold(
      (failure) => emit(CommunityHomeFailure(failure.message)),
      (community) => emit(CommunityHomeLoaded(community)),
    );
  }
}