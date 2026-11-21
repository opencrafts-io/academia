import 'package:flutter/services.dart';

import 'awesome_notifications_core_platform_interface.dart';

/// An implementation of [AwesomeNotificationsCorePlatform] that uses method channels.
class MethodChannelAwesomeNotificationsCore
    extends AwesomeNotificationsCorePlatform {
  /// The method channel used to interact with the native platform.
  final methodChannel = const MethodChannel('awesome_notifications_core');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
