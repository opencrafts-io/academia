// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_api_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommunityApiDto _$CommunityApiDtoFromJson(
  Map<String, dynamic> json,
) => _CommunityApiDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String?,
  nsfw: json['nsfw'] as bool? ?? false,
  private: json['private'] as bool? ?? false,
  verified: json['verified'] as bool? ?? false,
  visibility: json['visibility'] as String,
  memberCount: (json['member_count'] as num?)?.toInt() ?? 0,
  moderatorCount: (json['moderator_count'] as num?)?.toInt() ?? 0,
  bannedUsersCount: (json['banned_users_count'] as num?)?.toInt() ?? 0,
  monthlyVisitorCount: (json['monthly_visitor_count'] as num?)?.toInt() ?? 0,
  weeklyVisitorCount: (json['weekly_visitor_count'] as num?)?.toInt() ?? 0,
  banner: json['banner'] as String?,
  bannerHeight: (json['banner_height'] as num?)?.toInt() ?? 0,
  bannerWidth: (json['banner_width'] as num?)?.toInt() ?? 0,
  bannerUrl: json['banner_url'] as String?,
  profilePicture: json['profile_picture'] as String?,
  profilePictureHeight: (json['profile_picture_height'] as num?)?.toInt() ?? 0,
  profilePictureWidth: (json['profile_picture_width'] as num?)?.toInt() ?? 0,
  profilePictureUrl: json['profile_picture_url'] as String?,
  creatorId: json['creator_id'] as String,
  guidelines:
      (json['guidelines'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$CommunityApiDtoToJson(_CommunityApiDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'nsfw': instance.nsfw,
      'private': instance.private,
      'verified': instance.verified,
      'visibility': instance.visibility,
      'member_count': instance.memberCount,
      'moderator_count': instance.moderatorCount,
      'banned_users_count': instance.bannedUsersCount,
      'monthly_visitor_count': instance.monthlyVisitorCount,
      'weekly_visitor_count': instance.weeklyVisitorCount,
      'banner': instance.banner,
      'banner_height': instance.bannerHeight,
      'banner_width': instance.bannerWidth,
      'banner_url': instance.bannerUrl,
      'profile_picture': instance.profilePicture,
      'profile_picture_height': instance.profilePictureHeight,
      'profile_picture_width': instance.profilePictureWidth,
      'profile_picture_url': instance.profilePictureUrl,
      'creator_id': instance.creatorId,
      'guidelines': instance.guidelines,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
