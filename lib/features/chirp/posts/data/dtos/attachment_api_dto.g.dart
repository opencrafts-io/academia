// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_api_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttachmentApiDto _$AttachmentApiDtoFromJson(Map<String, dynamic> json) =>
    _AttachmentApiDto(
      id: (json['id'] as num).toInt(),
      attachmentType: json['attachment_type'] as String,
      file: json['file'] as String,
      size: (json['file_size'] as num).toInt(),
      name: json['original_filename'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      postId: (json['post'] as num).toInt(),
    );

Map<String, dynamic> _$AttachmentApiDtoToJson(_AttachmentApiDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attachment_type': instance.attachmentType,
      'file': instance.file,
      'file_size': instance.size,
      'original_filename': instance.name,
      'created_at': instance.createdAt.toIso8601String(),
      'post': instance.postId,
    };
