import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_api_dto.freezed.dart';
part 'community_api_dto.g.dart';

@freezed
abstract class CommunityApiDto with _$CommunityApiDto {
  const factory CommunityApiDto({
    required int id,
    required String name,
    String? description,
    @Default(false) bool nsfw,
    @Default(false) bool private,
    @Default(false) bool verified,
    required String visibility,
    @JsonKey(name: 'member_count') @Default(0) int memberCount,
    @JsonKey(name: 'moderator_count') @Default(0) int moderatorCount,
    @JsonKey(name: 'banned_users_count') @Default(0) int bannedUsersCount,
    @JsonKey(name: 'monthly_visitor_count')
    @Default(0)
    int monthlyVisitorCount,
    @JsonKey(name: 'weekly_visitor_count') @Default(0) int weeklyVisitorCount,
    String? banner,
    @JsonKey(name: 'banner_height') @Default(0) int bannerHeight,
    @JsonKey(name: 'banner_width') @Default(0) int bannerWidth,
    @JsonKey(name: 'banner_url') String? bannerUrl,
    @JsonKey(name: 'profile_picture') String? profilePicture,
    @JsonKey(name: 'profile_picture_height')
    @Default(0)
    int profilePictureHeight,
    @JsonKey(name: 'profile_picture_width')
    @Default(0)
    int profilePictureWidth,
    @JsonKey(name: 'profile_picture_url') String? profilePictureUrl,
    @JsonKey(name: 'creator_id') required String creatorId,
    @Default([]) List<String> guidelines,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _CommunityApiDto;

  factory CommunityApiDto.fromJson(Map<String, dynamic> json) =>
      _$CommunityApiDtoFromJson(json);
}
