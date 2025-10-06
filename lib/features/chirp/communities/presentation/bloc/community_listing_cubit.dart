import 'package:academia/features/features.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'community_listing_state.dart';

/// CommunityBloc
/// Manages all community related functionality e.g  performing
/// crud and manipulating community members
class CommunityListingCubit extends Cubit<CommunityListingState> {
  final GetPostableCommunitiesUsecase getPostableCommunitiesUsecase;
  final SearchForCommunityUsecase searchForCommunityUsecase;

  CommunityListingCubit({
    required this.getPostableCommunitiesUsecase,
    required this.searchForCommunityUsecase,
  }) : super(CommunityListingInitialState());

  /// Searches for a community specified by the search term
  /// [searchTerm] and emits a [CommunityListingRetrievedState] if
  /// it was successfull otherwise it just emits a [CommunityListingErrorState]
  ///
  /// Additional parameters like [page] and [pageSize] can be passed
  /// to facilitate pagination from th ui layer
  Future<void> searchForCommunity(
    String searchTerm, {
    int page = 1,
    pageSize = 50,
  }) async {
    final result = await searchForCommunityUsecase(
      SearchForCommunityUsecaseParams(
        searchTerm: searchTerm,
        page: page,
        pageSize: pageSize,
      ),
    );

    result.fold(
      (failure) {
        emit(CommunityListingErrorState(message: failure.message));
      },
      (retrievedCommunities) {
        emit(CommunityListingRetrievedState(retrieved: retrievedCommunities));
      },
    );
  }

  /// Attempts to fetch communities that a user is part of
  /// i.e where theyre allowed to make posts
  ///
  /// Additional parameters like [page] and [pageSize] can be passed
  /// to facilitate pagination from th ui layer

  Future<void> getPostableCommunities({int page = 1, pageSize = 50}) async {
    final result = await getPostableCommunitiesUsecase(
      GetPostableCommunitiesUsecaseParams(page: page, pageSize: pageSize),
    );

    result.fold(
      (failure) {
        emit(CommunityListingErrorState(message: failure.message));
      },
      (retrievedCommunities) {
        emit(CommunityListingRetrievedState(retrieved: retrievedCommunities));
      },
    );
  }
}
