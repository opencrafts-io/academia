import 'package:academia/features/chirp/communities/domain/entities/community_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_response.freezed.dart';

@freezed
abstract class PaginatedResponse with _$PaginatedResponse {
  const factory PaginatedResponse({
    required int count,
    String? next,
    String? previous,
    required List<CommunityUser> users,
  }) = _PaginatedResponse;
}
