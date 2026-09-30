import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('tracks client-owned paid-funnel milestones through the taxonomy', () {
    final homePage = File(
      'lib/features/home/presentation/screens/home_page.dart',
    ).readAsStringSync();
    final subscriptionManagementBloc = File(
      'packages/billing/lib/src/presentation/bloc/subscription_management_bloc.dart',
    ).readAsStringSync();

    expect(homePage, contains('AnalyticsEvent.paywallViewed()'));
    expect(
      subscriptionManagementBloc,
      contains('AnalyticsEvent.checkoutStarted()'),
    );
  });
}
