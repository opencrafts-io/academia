// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  id: json['id'] as String,
  name: json['name'] as String,
  username: json['username'] as String?,
  email: json['email'] as String,
  termsAccepted: json['terms_accepted'] as bool,
  onboarded: json['onboarded'] as bool,
  nationalID: json['national_id'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  bio: json['bio'] as String?,
  vibePoints: (json['vibe_points'] as num).toInt(),
  phone: json['phone'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  deletedAt: json['deleted_at'] == null
      ? null
      : DateTime.parse(json['deleted_at'] as String),
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'terms_accepted': instance.termsAccepted,
      'onboarded': instance.onboarded,
      'national_id': instance.nationalID,
      'avatar_url': instance.avatarUrl,
      'bio': instance.bio,
      'vibe_points': instance.vibePoints,
      'phone': instance.phone,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
    };
