import 'package:academia/features/communities/data/models/community_user_model.dart';
import 'package:academia/features/communities/data/models/paginated_user_response.dart';
import 'package:academia/features/communities/domain/entities/community_user.dart';
import 'package:academia/features/communities/domain/entities/paginated_response.dart';

extension CommunityUserModelHelper on CommunityUserModel {
  CommunityUser toEntity() {
    return CommunityUser(userId: userId, userName: userName, role: role);
  }
}

extension PaginatedUserResponseHelper on PaginatedUserResponse {
  PaginatedResponse toEntity() {
    return PaginatedResponse(
      count: count,
      next: next,
      previous: previous,
      users: users.map((user) => user.toEntity()).toList(),
    );
  }
}
