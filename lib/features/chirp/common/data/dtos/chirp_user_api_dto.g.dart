// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chirp_user_api_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChirpUserApiDto _$ChirpUserApiDtoFromJson(Map<String, dynamic> json) =>
    _ChirpUserApiDto(
      userId: json['user_id'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      username: json['username'] as String?,
      vibePoints: (json['vibe_points'] as num?)?.toInt() ?? 0,
      avatarUrl: json['avatar_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ChirpUserApiDtoToJson(_ChirpUserApiDto instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'email': instance.email,
      'phone': instance.phone,
      'username': instance.username,
      'vibe_points': instance.vibePoints,
      'avatar_url': instance.avatarUrl,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
