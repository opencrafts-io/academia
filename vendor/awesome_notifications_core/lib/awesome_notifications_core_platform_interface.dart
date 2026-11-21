import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'awesome_notifications_core_method_channel.dart';

abstract class AwesomeNotificationsCorePlatform extends PlatformInterface {
  /// Constructs a AwesomeNotificationsCorePlatform.
  AwesomeNotificationsCorePlatform() : super(token: _token);

  static final Object _token = Object();

  static AwesomeNotificationsCorePlatform _instance = MethodChannelAwesomeNotificationsCore();

  /// The default instance of [AwesomeNotificationsCorePlatform] to use.
  ///
  /// Defaults to [MethodChannelAwesomeNotificationsCore].
  static AwesomeNotificationsCorePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AwesomeNotificationsCorePlatform] when
  /// they register themselves.
  static set instance(AwesomeNotificationsCorePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
