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
  final PaginatedCommunity paginatedCommunity;
  CommunityListingLoadedState({required this.paginatedCommunity});

  @override
  List<Object?> get props => [paginatedCommunity];
}

// Fore representing a retrieval / search through the api
class CommunityListingRetrievedState extends CommunityListingState {
  final PaginatedCommunity retrieved;
  CommunityListingRetrievedState({required this.retrieved});

  @override
  List<Object?> get props => [retrieved];
}
