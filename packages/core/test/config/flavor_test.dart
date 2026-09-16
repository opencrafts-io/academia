import 'package:core/config/flavor.dart';
import 'package:test/test.dart';

void main() {
  group('FlavorConfig', () {
    test('exposes the selected flavor and its convenience flags', () {
      final config = FlavorConfig(
        flavor: Flavor.staging,
        appName: 'Academia Staging',
        apiBaseUrl: 'https://staging.example.com',
      );

      expect(config.flavorName, 'staging');
      expect(config.isDevelopment, isFalse);
      expect(config.isStaging, isTrue);
      expect(config.isProduction, isFalse);
    });
  });
}
