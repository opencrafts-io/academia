// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_user_api_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommunityUserApiDto _$CommunityUserApiDtoFromJson(Map<String, dynamic> json) =>
    _CommunityUserApiDto(
      userId: json['user_id'] as String,
      userName: json['user_name'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$CommunityUserApiDtoToJson(
  _CommunityUserApiDto instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'user_name': instance.userName,
  'role': instance.role,
};
