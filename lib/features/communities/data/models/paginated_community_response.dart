import 'package:academia/database/database.dart';

class PaginatedCommunityResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<CommunityData> communities;

  PaginatedCommunityResponse({
    required this.count,
    this.previous,
    this.next,
    required this.communities,
  });

  factory PaginatedCommunityResponse.fromJson(Map<String, dynamic> json) {
    final results = json["results"] as List;

    return PaginatedCommunityResponse(
      count: json["count"] ?? 0,
      next: json["next"],
      previous: json["previous"],
      communities: results.map((raw) => CommunityData.fromJson(raw)).toList(),
    );
  }
}
