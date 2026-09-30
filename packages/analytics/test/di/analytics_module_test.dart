import 'package:analytics/analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  test('registers the feature-flag reader through the package initializer', () {
    final getIt = GetIt.asNewInstance();

    configureAnalyticsDependencies(getIt);

    expect(getIt.isRegistered<FeatureFlagReader>(), isTrue);
    expect(getIt.isRegistered<AnalyticsGateway>(), isTrue);
    expect(getIt.isRegistered<AnalyticsTracker>(), isTrue);
  });
}
