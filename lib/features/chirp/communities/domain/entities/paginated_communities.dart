import 'community.dart';

class PaginatedCommunity {
  final int count;
  bool hasMore;
  final List<Community> communities;

  PaginatedCommunity({
    required this.count,
    this.hasMore = false,
    required this.communities,
  });
}
