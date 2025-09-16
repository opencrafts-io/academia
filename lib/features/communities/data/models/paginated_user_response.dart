import 'package:academia/features/communities/data/models/community_user_model.dart';

class PaginatedUserResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<CommunityUserModel> users;

  const PaginatedUserResponse({
    required this.count,
    this.next,
    this.previous,
    required this.users,
  });

  factory PaginatedUserResponse.fromJson(Map<String, dynamic> json) {
    final resultsJson = json['results'] as Map<String, dynamic>;
    List<dynamic> userListJson;

    // Dynamically check for the key that contains the user list
    if (resultsJson.containsKey('members')) {
      userListJson = resultsJson['members'] as List<dynamic>;
    } else if (resultsJson.containsKey('moderators')) {
      userListJson = resultsJson['moderators'] as List<dynamic>;
    } else if (resultsJson.containsKey('banned_users')) {
      userListJson = resultsJson['banned_users'] as List<dynamic>;
    } else {
      // Handle the case where none of the expected keys are found
      throw const FormatException(
        'Unexpected response format: no user list found.',
      );
    }
    return PaginatedUserResponse(
      count: json['count'] as int,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      users: userListJson
          .map(
            (item) => CommunityUserModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
