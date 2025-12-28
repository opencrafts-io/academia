// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrapping_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScrappingCommand _$ScrappingCommandFromJson(Map<String, dynamic> json) =>
    ScrappingCommand(
      commandID: json['commandID'] as String?,
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => ScrapingInstruction.fromJson(e as Map<String, dynamic>))
          .toList(),
      requiresInteraction: json['requires_interaction'] as bool?,
      url: json['url'] as String,
    );

Map<String, dynamic> _$ScrappingCommandToJson(ScrappingCommand instance) =>
    <String, dynamic>{
      'commandID': instance.commandID,
      'url': instance.url,
      'requires_interaction': instance.requiresInteraction,
      'instructions': instance.instructions,
    };
