import 'dart:convert';
import 'dart:io';

import 'package:academia/core/integration/portal_sync/portal_firebase_bootstrap.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final flavor in ['development', 'staging', 'production']) {
    test('uses the registered Firebase app for $flavor', () {
      final json = jsonDecode(
        File('android/app/src/$flavor/google-services.json').readAsStringSync(),
      ) as Map;
      final package =
          'io.opencrafts.academia${switch (flavor) {
            'development' => '.dev',
            'staging' => '.stg',
            _ => '',
          }}';
      final client = (json['client'] as List).cast<Map>().singleWhere(
        (client) =>
            client['client_info']['android_client_info']['package_name'] ==
            package,
      );
      final options = portalFirebaseOptionsForPlatform(
        TargetPlatform.android,
        androidPackageName: package,
      );
      expect(options.projectId, 'academia-28cec');
      expect(options.appId, client['client_info']['mobilesdk_app_id']);
      expect(options.apiKey, client['api_key'][0]['current_key']);
    });
  }
  test('uses the Academia iOS registration', () {
    final options = portalFirebaseOptionsForPlatform(TargetPlatform.iOS);
    expect(options.projectId, 'academia-28cec');
    expect(options.iosBundleId, 'io.opencrafts.academia');
    expect(options.appId, contains(':ios:'));
  });
}
