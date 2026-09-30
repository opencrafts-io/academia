import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:permissions/permissions.dart';
import 'package:settings/src/presentation/cubit/notification_preferences_cubit.dart';

import 'settings_module.config.dart';

@InjectableInit(
  initializerName: 'initSettings',
  preferRelativeImports: true,
  asExtension: false,
)
void configureSettingsDependencies(GetIt getIt) {
  initSettings(getIt);
  if (!getIt.isRegistered<NotificationPreferencesCubit>()) {
    getIt.registerFactory(
      () => NotificationPreferencesCubit(
        getIt<PermissionGateway>(),
        getIt<PermissionRequestObserver>(),
        supportsPreciseAlarms:
            !kIsWeb && defaultTargetPlatform == TargetPlatform.android,
      ),
    );
  }
}
