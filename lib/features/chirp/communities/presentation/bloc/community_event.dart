part of 'community_bloc.dart';

sealed class CommunityEvent extends Equatable {}

class CommunityPaginatedEventParameter {
  int page;
  int pageSize;

  CommunityPaginatedEventParameter({this.page = 1, this.pageSize = 100});
}

/// SearchCommunityEvent - For searching for a community
class SearchCommunityEvent extends CommunityEvent {
  final CommunityPaginatedEventParameter paginationParam;
  final String searchTerm;
  SearchCommunityEvent({
    required this.paginationParam,
    required this.searchTerm,
  });
  @override
  List<Object?> get props => [paginationParam, searchTerm];
}

/// CreateCommunityEvent - For creating a community.
// class CreateCommunityEvent extends CommunityEvent {
//   final String name;
//   final String description;
//   final bool isPublic;
//   final String userId;
//   final String userName;
//   final String userEmail;
//   final String? logoPath;
//   final String? bannerPath;
//
//   CreateCommunityEvent({
//     required this.name,
//     required this.description,
//     required this.isPublic,
//     required this.userId,
//     required this.userName,
//     required this.userEmail,
//     this.logoPath,
//     this.bannerPath,
//   });
//
//   @override
//   List<Object?> get props => [
//     name,
//     description,
//     isPublic,
//     userId,
//     userEmail,
//     userName,
//     logoPath,
//     bannerPath,
//   ];
// }

class GetPostableCommunityEvent extends CommunityEvent {
  final String searchTerm;
  GetPostableCommunityEvent({required this.searchTerm});

  @override
  List<Object?> get props => [searchTerm];
}
