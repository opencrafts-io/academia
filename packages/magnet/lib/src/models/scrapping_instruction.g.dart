// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrapping_instruction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WaitForUrl _$WaitForUrlFromJson(Map<String, dynamic> json) => _WaitForUrl(
  pattern: json['pattern'] as String,
  timeoutMs: (json['timeoutMs'] as num?)?.toInt() ?? 30000,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$WaitForUrlToJson(_WaitForUrl instance) =>
    <String, dynamic>{
      'pattern': instance.pattern,
      'timeoutMs': instance.timeoutMs,
      'runtimeType': instance.$type,
    };

_WaitForElement _$WaitForElementFromJson(Map<String, dynamic> json) =>
    _WaitForElement(
      selector: json['selector'] as String,
      timeoutMs: (json['timeoutMs'] as num?)?.toInt() ?? 30000,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$WaitForElementToJson(_WaitForElement instance) =>
    <String, dynamic>{
      'selector': instance.selector,
      'timeoutMs': instance.timeoutMs,
      'runtimeType': instance.$type,
    };

_WaitForElementDisappear _$WaitForElementDisappearFromJson(
  Map<String, dynamic> json,
) => _WaitForElementDisappear(
  selector: json['selector'] as String,
  timeoutMs: (json['timeoutMs'] as num?)?.toInt() ?? 30000,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$WaitForElementDisappearToJson(
  _WaitForElementDisappear instance,
) => <String, dynamic>{
  'selector': instance.selector,
  'timeoutMs': instance.timeoutMs,
  'runtimeType': instance.$type,
};

_WaitForNetworkIdle _$WaitForNetworkIdleFromJson(Map<String, dynamic> json) =>
    _WaitForNetworkIdle(
      timeoutMs: (json['timeoutMs'] as num?)?.toInt() ?? 30000,
      quietDurationMs: (json['quietDurationMs'] as num?)?.toInt() ?? 500,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$WaitForNetworkIdleToJson(_WaitForNetworkIdle instance) =>
    <String, dynamic>{
      'timeoutMs': instance.timeoutMs,
      'quietDurationMs': instance.quietDurationMs,
      'runtimeType': instance.$type,
    };

_WaitForAny _$WaitForAnyFromJson(Map<String, dynamic> json) => _WaitForAny(
  strategies: (json['strategies'] as List<dynamic>)
      .map((e) => WaitStrategy.fromJson(e as Map<String, dynamic>))
      .toList(),
  timeoutMs: (json['timeoutMs'] as num?)?.toInt() ?? 30000,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$WaitForAnyToJson(_WaitForAny instance) =>
    <String, dynamic>{
      'strategies': instance.strategies,
      'timeoutMs': instance.timeoutMs,
      'runtimeType': instance.$type,
    };

_WaitForAll _$WaitForAllFromJson(Map<String, dynamic> json) => _WaitForAll(
  strategies: (json['strategies'] as List<dynamic>)
      .map((e) => WaitStrategy.fromJson(e as Map<String, dynamic>))
      .toList(),
  timeoutMs: (json['timeoutMs'] as num?)?.toInt() ?? 30000,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$WaitForAllToJson(_WaitForAll instance) =>
    <String, dynamic>{
      'strategies': instance.strategies,
      'timeoutMs': instance.timeoutMs,
      'runtimeType': instance.$type,
    };

_ScrapingInstruction _$ScrapingInstructionFromJson(Map<String, dynamic> json) =>
    _ScrapingInstruction(
      type: json['type'] as String,
      selector: json['selector'] as String?,
      xpath: json['xpath'] as String?,
      attribute: json['attribute'] as String?,
      value: json['value'] as String?,
      waitMilliseconds: (json['waitMilliseconds'] as num?)?.toInt(),
      waitStrategy: json['waitStrategy'] == null
          ? null
          : WaitStrategy.fromJson(json['waitStrategy'] as Map<String, dynamic>),
      jsCode: json['jsCode'] as String?,
      outputKey: json['outputKey'] as String?,
      waitAfterExecution: json['waitAfterExecution'] as bool? ?? false,
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
  'waitStrategy': instance.waitStrategy,
  'jsCode': instance.jsCode,
  'outputKey': instance.outputKey,
  'waitAfterExecution': instance.waitAfterExecution,
};
