import 'package:awesome_notifications_core/awesome_notifications_core_method_channel.dart';
import 'package:awesome_notifications_core/awesome_notifications_core_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAwesomeNotificationsCorePlatform
    with MockPlatformInterfaceMixin
    implements AwesomeNotificationsCorePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AwesomeNotificationsCorePlatform initialPlatform = AwesomeNotificationsCorePlatform.instance;

  test('$MethodChannelAwesomeNotificationsCore is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAwesomeNotificationsCore>());
  });

  test('getPlatformVersion', () async {
  });
}
