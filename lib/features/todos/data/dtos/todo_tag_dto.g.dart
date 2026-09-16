// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_tag_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TodoTagDto _$TodoTagDtoFromJson(Map<String, dynamic> json) => _TodoTagDto(
  id: json['id'] as String?,
  name: json['name'] as String,
  color: json['color'] as String?,
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$TodoTagDtoToJson(_TodoTagDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'created_at': instance.createdAt,
    };
