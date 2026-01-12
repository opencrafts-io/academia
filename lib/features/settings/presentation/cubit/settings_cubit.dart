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

  void toggleEnableMaterialYou() =>
      emit(state.copyWith(enableMaterialYou: !state.enableMaterialYou));

  void toggleEnableExtraDarkMode() =>
      emit(state.copyWith(extraDarkMode: !state.extraDarkMode));

  void toggleEnableAutomaticAccentColor() => emit(
    state.copyWith(
      automaticallyPickAccentColor: !state.automaticallyPickAccentColor,
    ),
  );

  @override
  SettingsState? fromJson(Map<String, dynamic> json) =>
      SettingsState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(SettingsState state) => state.toJson();
}
