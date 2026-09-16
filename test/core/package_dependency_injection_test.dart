import 'package:academia/core/di/injection.dart';
import 'package:analytics/analytics.dart';
import 'package:core/config/flavor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:in_app_update/in_app_update.dart';

void main() {
  test('configures package-owned analytics and update dependencies centrally', () {
    final getIt = GetIt.asNewInstance();

    configureDependencies(
      getIt,
      FlavorConfig(
        flavor: Flavor.staging,
        appName: 'Academia - Staging',
        apiBaseUrl: 'https://api.opencrafts.io',
      ),
    );

    expect(getIt<FeatureFlagReader>(), isA<FeatureFlagReader>());
    expect(getIt<InAppUpdateBloc>(), isA<InAppUpdateBloc>());
    expect(
      getIt<AppUpdateConfigurationSource>(),
      isA<DisabledAppUpdateConfigurationSource>(),
    );
  });
}
