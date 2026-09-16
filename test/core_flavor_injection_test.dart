import 'package:core/config/flavor.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  test(
    'registers the runtime flavor through the core injectable initializer',
    () {
      final getIt = GetIt.asNewInstance();
      final flavor = FlavorConfig(
        flavor: Flavor.production,
        appName: 'Academia',
        apiBaseUrl: 'https://api.example.com',
      );

      configureCoreDependencies(getIt, flavor);

      expect(getIt<FlavorConfig>(), same(flavor));
    },
  );
}
