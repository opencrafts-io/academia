import 'package:academia/features/features.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'community_listing_state.dart';

/// CommunityBloc
/// Manages all community related functionality e.g performing
/// crud and manipulating community members
class CommunityListingCubit extends Cubit<CommunityListingState> {
  final GetPostableCommunitiesUsecase getPostableCommunitiesUsecase;
  final SearchForCommunityUsecase searchForCommunityUsecase;

  int _currentPage = 1;
  static const int _pageSize = 50;

  String? _currentSearchTerm;
  bool _isFetching = false;

  CommunityListingCubit({
    required this.getPostableCommunitiesUsecase,
    required this.searchForCommunityUsecase,
  }) : super(CommunityListingInitialState());

  bool _isFirstPage(int page) => page == 1;

  Future<void> getPostableCommunities({int page = 1}) async {
    if (_isFetching) return;
    _isFetching = true;

    if (_isFirstPage(page)) {
      _currentPage = 1;
      _currentSearchTerm = null; // Clear any active search term
      emit(CommunityListingLoadingState());
    } else {
      if (state is CommunityListingLoadedState) {
        emit(
          (state as CommunityListingLoadedState).copyWith(isLoadingMore: true),
        );
      } else {
        return;
      }
    }

    final result = await getPostableCommunitiesUsecase(
      GetPostableCommunitiesUsecaseParams(
        page: _currentPage,
        pageSize: _pageSize,
      ),
    );

    result.fold(
      (failure) {
        if (state is CommunityListingLoadedState) {
          emit(
            (state as CommunityListingLoadedState).copyWith(
              isLoadingMore: false,
            ),
          );
        } else {
          emit(CommunityListingErrorState(message: failure.message));
        }
        _isFetching = false;
      },
      (newCommunities) {
        final List<Community> currentCommunities =
            (_isFirstPage(page) || state is! CommunityListingLoadedState)
            ? []
            : (state as CommunityListingLoadedState).communities;

        final List<Community> allCommunities = [
          ...currentCommunities,
          ...newCommunities,
        ];

        final bool hasReachedMax = newCommunities.length < _pageSize;

        emit(
          CommunityListingLoadedState(
            communities: allCommunities,
            hasReachedMax: hasReachedMax,
            isLoadingMore: false,
            searchTerm: null,
          ),
        );

        if (!hasReachedMax) {
          _currentPage++;
        }

        _isFetching = false;
      },
    );
  }

  Future<void> searchForCommunity(String searchTerm, {int page = 1}) async {
    if (searchTerm.isEmpty) {
      return getPostableCommunities();
    }

    if (_isFirstPage(page) || searchTerm != _currentSearchTerm) {
      _currentPage = 1;
      _currentSearchTerm = searchTerm;
      emit(CommunityListingLoadingState());
    } else {
      if (state is CommunityListingLoadedState) {
        emit(
          (state as CommunityListingLoadedState).copyWith(isLoadingMore: true),
        );
      } else {
        return;
      }
    }

    final pageToFetch = _currentPage;

    final result = await searchForCommunityUsecase(
      SearchForCommunityUsecaseParams(
        searchTerm: _currentSearchTerm!,
        page: pageToFetch,
        pageSize: _pageSize,
      ),
    );

    result.fold(
      (failure) {
        if (state is CommunityListingLoadedState) {
          emit(
            (state as CommunityListingLoadedState).copyWith(
              isLoadingMore: false,
            ),
          );
        } else {
          emit(CommunityListingErrorState(message: failure.message));
        }
      },
      (newCommunities) {
        final List<Community> currentCommunities =
            (_isFirstPage(pageToFetch) ||
                state is! CommunityListingLoadedState ||
                (state as CommunityListingLoadedState).searchTerm !=
                    _currentSearchTerm)
            ? []
            : (state as CommunityListingLoadedState).communities;

        final List<Community> allCommunities = [
          ...currentCommunities,
          ...newCommunities,
        ];

        final bool hasReachedMax = newCommunities.length < _pageSize;

        emit(
          CommunityListingLoadedState(
            communities: allCommunities,
            hasReachedMax: hasReachedMax,
            isLoadingMore: false,
            searchTerm: _currentSearchTerm, // Set the active search term
          ),
        );

        if (!hasReachedMax) {
          _currentPage++; // Increment page for the next search request
        }
      },
    );
  }
}
