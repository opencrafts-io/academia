import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'settings_state.dart';
import 'package:flutter/material.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void updateTheme(ThemeMode mode) => emit(state.copyWith(themeMode: mode));

  void updateColor(int colorValue) =>
      emit(state.copyWith(colorSeedValue: colorValue));

  void toggleCompactMode() =>
      emit(state.copyWith(compactMode: !state.compactMode));

  @override
  SettingsState? fromJson(Map<String, dynamic> json) =>
      SettingsState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(SettingsState state) => state.toJson();
}
