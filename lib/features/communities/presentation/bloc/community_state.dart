part of 'community_bloc.dart';

sealed class CommunityState extends Equatable {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class CommunityInitialState extends CommunityState {}

class CommunityLoadingState extends CommunityState {}

class CommunitySearchingState extends CommunityState {}

class CommunityErrorState extends CommunityState {
  final String message;
  CommunityErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class CommunitiesLoadedState extends CommunityState {
  final List<Community> communities;
  CommunitiesLoadedState({required this.communities});

  @override
  List<Object?> get props => [communities];
}

// Fore representing a retrieval / search through the api
class CommunitiesRetrievedState extends CommunityState {
  final PaginatedCommunity retrieved;
  CommunitiesRetrievedState({required this.retrieved});

  @override
  List<Object?> get props => [retrieved];
}
