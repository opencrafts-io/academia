// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrapping_instruction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScrapingInstruction _$ScrapingInstructionFromJson(Map<String, dynamic> json) =>
    _ScrapingInstruction(
      type: json['type'] as String,
      selector: json['selector'] as String?,
      xpath: json['xpath'] as String?,
      attribute: json['attribute'] as String?,
      value: json['value'] as String?,
      waitMilliseconds: (json['waitMilliseconds'] as num?)?.toInt(),
      jsCode: json['jsCode'] as String?,
      outputKey: json['outputKey'] as String?,
      steps: (json['steps'] as List<dynamic>?)
          ?.map((e) => ScrapingInstruction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScrapingInstructionToJson(
  _ScrapingInstruction instance,
) => <String, dynamic>{
  'type': instance.type,
  'selector': instance.selector,
  'xpath': instance.xpath,
  'attribute': instance.attribute,
  'value': instance.value,
  'waitMilliseconds': instance.waitMilliseconds,
  'jsCode': instance.jsCode,
  'outputKey': instance.outputKey,
  'steps': instance.steps,
};
