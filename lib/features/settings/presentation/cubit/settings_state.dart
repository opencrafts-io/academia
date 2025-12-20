import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';
part 'settings_state.g.dart';

class ThemeModeConverter implements JsonConverter<ThemeMode, String> {
  const ThemeModeConverter();

  @override
  ThemeMode fromJson(String json) {
    return ThemeMode.values.firstWhere(
      (mode) => mode.toString() == 'ThemeMode.$json',
      orElse: () => ThemeMode.system,
    );
  }

  @override
  String toJson(ThemeMode object) => object.toString().split('.').last;
}

@freezed
abstract class SettingsState with _$SettingsState {
  const SettingsState._();

  const factory SettingsState({
    @ThemeModeConverter() @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(0xFF6200EE) int colorSeedValue,
    @Default(false) bool compactMode,
    @Default('en') String language,
  }) = _SettingsState;

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);
}
