// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block_api_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BlockApiDto _$BlockApiDtoFromJson(Map<String, dynamic> json) => _BlockApiDto(
  id: (json['id'] as num).toInt(),
  blockType: json['block_type'] as String,
  blockedUser: json['blocked_user'] as String?,
  blockedCommunity: (json['blocked_community'] as num?)?.toInt(),
  blockedName: json['blocked_name'] as String?,
  blockedImage: json['blocked_image'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$BlockApiDtoToJson(_BlockApiDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'block_type': instance.blockType,
      'blocked_user': instance.blockedUser,
      'blocked_community': instance.blockedCommunity,
      'blocked_name': instance.blockedName,
      'blocked_image': instance.blockedImage,
      'created_at': instance.createdAt.toIso8601String(),
    };
