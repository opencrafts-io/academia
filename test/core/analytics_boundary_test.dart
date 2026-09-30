import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('product analytics call sites use the analytics package boundary', () {
    const productAnalyticsSources = [
      'lib/config/router/app_router.dart',
      'lib/core/permissions/analytics_permission_request_observer.dart',
      'lib/features/auth/presentation/bloc/auth_bloc.dart',
      'lib/features/institution/presentation/bloc/institution_bloc.dart',
      'lib/features/profile/presentation/bloc/profile_bloc.dart',
    ];

    for (final path in productAnalyticsSources) {
      final source = File(path).readAsStringSync();

      expect(source, isNot(contains('package:posthog_flutter')));
      expect(source, isNot(contains('Posthog(')));
    }

    expect(
      File('lib/config/router/app_router.dart').readAsStringSync(),
      contains('AnalyticsRouteObserver'),
    );
  });
}
