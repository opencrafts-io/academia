import 'package:billing/src/data/datasources/billing_api_paths.dart';
import 'package:core/config/flavor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('uses the production billing prefix for the production flavor', () {
    final paths = BillingApiPaths(
      FlavorConfig(
        flavor: Flavor.production,
        appName: 'Academia',
        apiBaseUrl: 'https://api.example.com',
      ),
    );

    expect(paths.plans, '/verisafe/plans');
  });

  test('uses the QA billing prefix outside production', () {
    final paths = BillingApiPaths(
      FlavorConfig(
        flavor: Flavor.staging,
        appName: 'Academia Staging',
        apiBaseUrl: 'https://staging.example.com',
      ),
    );

    expect(paths.plans, '/qa-verisafe/plans');
  });
}
