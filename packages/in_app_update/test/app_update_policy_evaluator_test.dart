import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:pub_semver/pub_semver.dart';

void main() {
  final evaluator = AppUpdatePolicyEvaluator();
  final fallbackStoreUrl = Uri.parse(
    'https://play.google.com/store/apps/details?id=io.opencrafts.academia',
  );

  test('requires an update below an applicable required campaign target', () {
    final decision = evaluator.evaluate(
      rawConfiguration: {
        'schema_version': 2,
        'platforms': {
          'android': {
            'campaigns': [
              {
                'id': 'android-3-4-required',
                'target_version': '3.4.0',
                'mode': 'required',
                'title': 'Update required',
                'message': 'This version is no longer supported.',
              },
            ],
          },
        },
      },
      platform: AppUpdatePlatform.android,
      currentVersion: Version.parse('3.3.1'),
      fallbackStoreUrl: fallbackStoreUrl,
    );

    expect(decision, isA<RequiredAppUpdate>());
    expect((decision as RequiredAppUpdate).campaign.id, 'android-3-4-required');
  });

  test(
    'prioritizes an applicable required campaign over optional campaigns',
    () {
      final decision = evaluator.evaluate(
        rawConfiguration: {
          'schema_version': 2,
          'platforms': {
            'android': {
              'campaigns': [
                {
                  'id': 'android-3-5-optional',
                  'target_version': '3.5.0',
                  'mode': 'optional',
                  'title': 'A newer app is ready',
                  'message': 'Update when you are ready.',
                },
                {
                  'id': 'android-3-4-required',
                  'target_version': '3.4.0',
                  'mode': 'required',
                  'title': 'Update required',
                  'message': 'Install the supported release.',
                },
              ],
            },
          },
        },
        platform: AppUpdatePlatform.android,
        currentVersion: Version.parse('3.3.1'),
        fallbackStoreUrl: fallbackStoreUrl,
      );

      expect(decision, isA<RequiredAppUpdate>());
      expect(
        (decision as RequiredAppUpdate).campaign.id,
        'android-3-4-required',
      );
    },
  );

  test('uses the legacy configuration when no v2 payload is present', () {
    final decision = evaluator.evaluate(
      rawConfiguration: {
        'message': 'Please update Academia.',
        'android': {'min_version': '3.4.0', 'is_critical': false},
      },
      platform: AppUpdatePlatform.android,
      currentVersion: Version.parse('3.3.1'),
      fallbackStoreUrl: fallbackStoreUrl,
    );

    expect(decision, isA<OptionalAppUpdate>());
    expect(
      (decision as OptionalAppUpdate).campaign.message,
      'Please update Academia.',
    );
  });

  test(
    'fails open when remote configuration does not contain a valid campaign',
    () {
      final decision = evaluator.evaluate(
        rawConfiguration: {
          'schema_version': 2,
          'platforms': {
            'android': {
              'campaigns': [
                {
                  'id': 'untrusted-store',
                  'target_version': '3.4.0',
                  'mode': 'required',
                  'title': 'Update required',
                  'message': 'Install the supported release.',
                  'store_url': 'https://example.invalid/update',
                },
              ],
            },
          },
        },
        platform: AppUpdatePlatform.android,
        currentVersion: Version.parse('3.3.1'),
        fallbackStoreUrl: Uri.parse('https://example.invalid/fallback'),
      );

      expect(decision, const NoAppUpdate());
    },
  );
}
