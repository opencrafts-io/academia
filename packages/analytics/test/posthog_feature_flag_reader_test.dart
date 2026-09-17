import 'package:analytics/analytics.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('reads a named feature-flag payload through its gateway', () async {
    final gateway = _Gateway({'schema_version': 2});
    final reader = PosthogFeatureFlagReader(gateway);

    final payload = await reader.readJson('app-upgrade-config');

    expect(gateway.requestedKey, 'app-upgrade-config');
    expect(payload, {'schema_version': 2});
  });
}

class _Gateway implements PosthogFeatureFlagGateway {
  _Gateway(this._payload);

  final Object? _payload;
  String? requestedKey;

  @override
  Future<bool> isEnabled(String key) async => false;

  @override
  Future<Object?> readPayload(String key) async {
    requestedKey = key;
    return _payload;
  }
}
