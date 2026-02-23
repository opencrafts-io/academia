// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrapping_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScrappingCommand _$ScrappingCommandFromJson(Map<String, dynamic> json) =>
    _ScrappingCommand(
      commandID: json['command_id'] as String?,
      url: json['url'] as String,
      requiresInteraction: json['requires_interaction'] as bool? ?? false,
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => ScrapingInstruction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScrappingCommandToJson(_ScrappingCommand instance) =>
    <String, dynamic>{
      'command_id': instance.commandID,
      'url': instance.url,
      'requires_interaction': instance.requiresInteraction,
      'instructions': instance.instructions,
    };
