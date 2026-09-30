import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Android declares notification and exact-alarm permissions', () {
    final manifest = File(
      'android/app/src/main/AndroidManifest.xml',
    ).readAsStringSync();

    expect(manifest, contains('android.permission.POST_NOTIFICATIONS'));
    expect(manifest, contains('android.permission.SCHEDULE_EXACT_ALARM'));
  });

  test('iOS keeps remote notifications and the OneSignal service extension', () {
    final infoPlist = File('ios/Runner/Info.plist').readAsStringSync();

    expect(infoPlist, contains('<string>remote-notification</string>'));
    expect(
      File(
        'ios/OneSignalNotificationServiceExtension/NotificationService.swift',
      ).existsSync(),
      isTrue,
    );
  });
}
