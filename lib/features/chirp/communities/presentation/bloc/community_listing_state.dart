part of 'community_listing_cubit.dart';

sealed class CommunityListingState extends Equatable {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class CommunityListingInitialState extends CommunityListingState {}

class CommunityListingLoadingState extends CommunityListingState {}

class CommunityListingSearchingState extends CommunityListingState {}

class CommunityListingErrorState extends CommunityListingState {
  final String message;
  CommunityListingErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class CommunityListingLoadedState extends CommunityListingState {
  final List<Community> communities;
  final bool hasReachedMax; // Indicates if all pages have been loaded
  final bool isLoadingMore;
  final String? searchTerm;

  CommunityListingLoadedState({
    required this.communities,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
    this.searchTerm,
  });

  CommunityListingLoadedState copyWith({
    List<Community>? communities,
    bool? hasReachedMax,
    bool? isLoadingMore,
    String? searchTerm,
  }) {
    return CommunityListingLoadedState(
      communities: communities ?? this.communities,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }

  @override
  List<Object?> get props => [communities, hasReachedMax, isLoadingMore];
}

