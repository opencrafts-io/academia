import 'package:academia/features/chirp/communities/data/dtos/community_user_api_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_user_response.freezed.dart';

@freezed
abstract class PaginatedUserResponse with _$PaginatedUserResponse {
  const factory PaginatedUserResponse({
    required int count,
    String? next,
    String? previous,
    required List<CommunityUserApiDto> users,
  }) = _PaginatedUserResponse;

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
            (item) =>
                CommunityUserApiDto.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
