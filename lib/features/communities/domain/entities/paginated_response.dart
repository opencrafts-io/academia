import 'package:academia/features/communities/domain/entities/community_user.dart';

class PaginatedResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<CommunityUser> users;

  const PaginatedResponse({
    required this.count,
    this.next,
    this.previous,
    required this.users,
  });
}
