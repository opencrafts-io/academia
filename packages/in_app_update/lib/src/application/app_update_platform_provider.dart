import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:in_app_update/src/domain/app_update_platform.dart';

abstract interface class AppUpdatePlatformProvider {
  AppUpdatePlatform? get currentPlatform;
}

@LazySingleton(as: AppUpdatePlatformProvider)
class DeviceAppUpdatePlatformProvider implements AppUpdatePlatformProvider {
  const DeviceAppUpdatePlatformProvider();

  @override
  AppUpdatePlatform? get currentPlatform {
    if (kIsWeb) return null;
    if (Platform.isAndroid) return AppUpdatePlatform.android;
    if (Platform.isIOS) return AppUpdatePlatform.ios;
    return null;
  }
}
