// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettingsState _$SettingsStateFromJson(Map<String, dynamic> json) =>
    _SettingsState(
      themeMode: json['themeMode'] == null
          ? ThemeMode.system
          : const ThemeModeConverter().fromJson(json['themeMode'] as String),
      colorSeedValue: (json['colorSeedValue'] as num?)?.toInt() ?? 0xFF6200EE,
      compactMode: json['compactMode'] as bool? ?? false,
      extraDarkMode: json['extraDarkMode'] as bool? ?? false,
      enableMaterialYou: json['enableMaterialYou'] as bool? ?? true,
      automaticallyPickAccentColor:
          json['automaticallyPickAccentColor'] as bool? ?? true,
      language: json['language'] as String? ?? 'en',
    );

Map<String, dynamic> _$SettingsStateToJson(_SettingsState instance) =>
    <String, dynamic>{
      'themeMode': const ThemeModeConverter().toJson(instance.themeMode),
      'colorSeedValue': instance.colorSeedValue,
      'compactMode': instance.compactMode,
      'extraDarkMode': instance.extraDarkMode,
      'enableMaterialYou': instance.enableMaterialYou,
      'automaticallyPickAccentColor': instance.automaticallyPickAccentColor,
      'language': instance.language,
    };
