import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:settings/settings.dart';

class _InMemoryStorage implements Storage {
  final Map<String, dynamic> _values = {};

  @override
  dynamic read(String key) => _values[key];

  @override
  Future<void> write(String key, dynamic value) async {
    _values[key] = value;
  }

  @override
  Future<void> delete(String key) async {
    _values.remove(key);
  }

  @override
  Future<void> clear() async {
    _values.clear();
  }

  @override
  Future<void> close() async {}
}

void main() {
  setUp(() {
    HydratedBloc.storage = _InMemoryStorage();
  });

  test('registers independent settings cubits with the default preference', () {
    final getIt = GetIt.asNewInstance();

    configureSettingsDependencies(getIt);

    final firstCubit = getIt<SettingsCubit>();
    final secondCubit = getIt<SettingsCubit>();

    expect(firstCubit, isNot(same(secondCubit)));
    expect(firstCubit.state.themeMode, ThemeMode.system);
  });

  test('exposes the settings page through its typed route', () {
    const route = SettingsPageRoute();

    expect(route.location, '/settings');
    expect(routes, hasLength(1));
  });
}
