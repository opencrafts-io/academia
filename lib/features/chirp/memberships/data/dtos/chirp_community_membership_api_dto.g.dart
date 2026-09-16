// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chirp_community_membership_api_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChirpCommunityMembershipApiDto _$ChirpCommunityMembershipApiDtoFromJson(
  Map<String, dynamic> json,
) => _ChirpCommunityMembershipApiDto(
  id: (json['id'] as num).toInt(),
  communityID: (json['community_id'] as num).toInt(),
  userID: json['user_id'] as String,
  role: json['role'] as String,
  banned: json['banned'] as bool? ?? false,
  bannedByID: json['banned_by_id'] as String?,
  bannedReason: json['banning_reason'] as String?,
  bannedAt: json['banned_at'] == null
      ? null
      : DateTime.parse(json['banned_at'] as String),
  joinedAt: DateTime.parse(json['joined_at'] as String),
);

Map<String, dynamic> _$ChirpCommunityMembershipApiDtoToJson(
  _ChirpCommunityMembershipApiDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'community_id': instance.communityID,
  'user_id': instance.userID,
  'role': instance.role,
  'banned': instance.banned,
  'banned_by_id': instance.bannedByID,
  'banning_reason': instance.bannedReason,
  'banned_at': instance.bannedAt?.toIso8601String(),
  'joined_at': instance.joinedAt.toIso8601String(),
};
