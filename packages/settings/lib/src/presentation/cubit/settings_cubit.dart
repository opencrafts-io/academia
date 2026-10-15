import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import 'settings_state.dart';

@injectable
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

  void toggleShowDailyScheduleOnFeed() => emit(
    state.copyWith(showDailyScheduleOnFeed: !state.showDailyScheduleOnFeed),
  );

  void toggleChirpMuteVideos() =>
      emit(state.copyWith(chirpMuteVideos: !state.chirpMuteVideos));

  void toggleCourseReminders() => emit(
    state.copyWith(courseRemindersEnabled: !state.courseRemindersEnabled),
  );

  void updateCourseReminderMinutes(int index, int? minutes) {
    if (index < 0 || index >= 3) return;
    final values = List<int?>.generate(
      3,
      (slot) => slot < state.courseReminderMinutes.length
          ? state.courseReminderMinutes[slot]
          : null,
    );
    if (minutes != null &&
        values.asMap().entries.any(
          (entry) => entry.key != index && entry.value == minutes,
        )) {
      return;
    }
    values[index] = minutes;
    emit(state.copyWith(courseReminderMinutes: values));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) =>
      SettingsState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(SettingsState state) => state.toJson();
}
