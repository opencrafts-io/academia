import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/features.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'community_event.dart';
part 'community_state.dart';

/// CommunityBloc
/// Manages all community related functionality e.g  performing
/// crud and manipulating community members
class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  final GetPostableCommunitiesUsecase getPostableCommunitiesUsecase;
  final SearchForCommunityUsecase searchForCommunityUsecase;

  CommunityBloc({
    required this.getPostableCommunitiesUsecase,
    required this.searchForCommunityUsecase,
  }) : super(CommunityInitialState()) {
    on(_onGetPostableCommunities);
    on(_onSearchCommunities);
  }

  Future<void> _onGetPostableCommunities(
    GetPostableCommunityEvent event,
    Emitter<CommunityState> emit,
  ) async {
    emit(CommunityLoadingState());
    final result = await getPostableCommunitiesUsecase(NoParams());
    result.fold(
      (error) => emit(CommunityErrorState(message: error.message)),
      (communities) => emit(CommunitiesLoadedState(communities: communities)),
    );
  }

  Future<void> _onSearchCommunities(
    SearchCommunityEvent event,
    Emitter<CommunityState> emit,
  ) async {
    final result = await searchForCommunityUsecase(
      SearchForCommunityUsecaseParams(
        searchTerm: event.searchTerm,
        page: event.paginationParam.page,
        pageSize: event.paginationParam.pageSize,
      ),
    );

    result.fold(
      (failure) => emit(CommunityErrorState(message: failure.message)),
      (searched) => emit(CommunitiesRetrievedState(retrieved: searched)),
    );
  }
}
