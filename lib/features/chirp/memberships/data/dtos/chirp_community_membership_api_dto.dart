import 'package:freezed_annotation/freezed_annotation.dart';

part 'chirp_community_membership_api_dto.freezed.dart';
part 'chirp_community_membership_api_dto.g.dart';

@freezed
abstract class ChirpCommunityMembershipApiDto
    with _$ChirpCommunityMembershipApiDto {
  const factory ChirpCommunityMembershipApiDto({
    required int id,
    @JsonKey(name: 'community_id') required int communityID,
    @JsonKey(name: 'user_id') required String userID,
    required String role,
    @Default(false) bool banned,
    @JsonKey(name: 'banned_by_id') String? bannedByID,
    @JsonKey(name: 'banning_reason') String? bannedReason,
    @JsonKey(name: 'banned_at') DateTime? bannedAt,
    @JsonKey(name: 'joined_at') required DateTime joinedAt,
  }) = _ChirpCommunityMembershipApiDto;

  factory ChirpCommunityMembershipApiDto.fromJson(Map<String, dynamic> json) =>
      _$ChirpCommunityMembershipApiDtoFromJson(json);
}
