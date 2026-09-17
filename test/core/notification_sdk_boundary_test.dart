import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('the app uses notification SDKs only through the internal package', () {
    final directSdkImports = Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'))
        .where((file) {
          final source = file.readAsStringSync();
          return source.contains('package:awesome_notifications/') ||
              source.contains('package:onesignal_flutter/');
        })
        .map((file) => file.path)
        .toList();

    expect(directSdkImports, isEmpty);
  });

  test('notification actions do not dispatch arbitrary URLs', () {
    final notificationSources = File(
      'lib/core/notifications/academia_notification_action_handler.dart',
    ).readAsStringSync();

    expect(notificationSources, isNot(contains('launchUrl(')));
  });
}
