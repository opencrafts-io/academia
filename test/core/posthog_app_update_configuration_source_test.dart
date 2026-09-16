import 'package:academia/core/in_app_update/posthog_app_update_configuration_source.dart';
import 'package:analytics/analytics.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'loads the configured update flag through the generic analytics reader',
    () async {
      final reader = _FeatureFlagReader({'schema_version': 2});
      final source = PosthogAppUpdateConfigurationSource(reader);

      final payload = await source.load();

      expect(reader.requestedKey, 'app-upgrade-config');
      expect(payload, {'schema_version': 2});
    },
  );
}

class _FeatureFlagReader implements FeatureFlagReader {
  _FeatureFlagReader(this._payload);

  final Object? _payload;
  String? requestedKey;

  @override
  Future<Object?> readJson(String key) async {
    requestedKey = key;
    return _payload;
  }
}
