// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'institution_scrapping_command_api_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InstitutionScrappingCommandApiDto _$InstitutionScrappingCommandApiDtoFromJson(
  Map<String, dynamic> json,
) => _InstitutionScrappingCommandApiDto(
  institution: (json['institution'] as num).toInt(),
  commandId: json['command_id'] as String,
  name: json['name'] as String,
  url: json['url'] as String?,
  description: json['description'] as String?,
  requiresInteraction: json['requires_interaction'] as bool? ?? false,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  instructions: json['instructions'] as List<dynamic>,
);

Map<String, dynamic> _$InstitutionScrappingCommandApiDtoToJson(
  _InstitutionScrappingCommandApiDto instance,
) => <String, dynamic>{
  'institution': instance.institution,
  'command_id': instance.commandId,
  'name': instance.name,
  'url': instance.url,
  'description': instance.description,
  'requires_interaction': instance.requiresInteraction,
  'created_at': instance.createdAt?.toIso8601String(),
  'instructions': instance.instructions,
};
