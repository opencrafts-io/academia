// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_tip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SplashTip _$SplashTipFromJson(Map<String, dynamic> json) => _SplashTip(
  id: json['id'] as String,
  title: json['title'] as String,
  message: json['message'] as String,
  actionLabel: json['actionLabel'] as String? ?? '',
  action: $enumDecodeNullable(_$SplashTipActionEnumMap, json['action']),
);

Map<String, dynamic> _$SplashTipToJson(_SplashTip instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'actionLabel': instance.actionLabel,
      'action': _$SplashTipActionEnumMap[instance.action],
    };

const _$SplashTipActionEnumMap = {
  SplashTipAction.premium: 'premium',
  SplashTipAction.notifications: 'notifications',
  SplashTipAction.lockIn: 'lock_in',
};

_SplashTipConfiguration _$SplashTipConfigurationFromJson(
  Map<String, dynamic> json,
) => _SplashTipConfiguration(
  enabled: json['enabled'] as bool? ?? true,
  minimumDisplayMs: (json['minimumDisplayMs'] as num?)?.toInt() ?? 2200,
  tips:
      (json['tips'] as List<dynamic>?)
          ?.map((e) => SplashTip.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SplashTip>[],
);

Map<String, dynamic> _$SplashTipConfigurationToJson(
  _SplashTipConfiguration instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'minimumDisplayMs': instance.minimumDisplayMs,
  'tips': instance.tips,
};
