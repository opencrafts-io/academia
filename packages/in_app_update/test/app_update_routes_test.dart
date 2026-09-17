import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:pub_semver/pub_semver.dart';

void main() {
  final campaign = UpdateCampaign(
    id: 'update-required',
    targetVersion: Version.parse('3.4.0'),
    mode: AppUpdateMode.required,
    title: 'Update required',
    message: 'Install the supported release.',
    storeUrl: Uri.parse(
      'https://play.google.com/store/apps/details?id=io.opencrafts.academia',
    ),
  );

  test('required update route keeps campaign data out of its location', () {
    final route = AppUpdateRequiredRoute($extra: campaign);

    expect(route.location, '/app-update/required');
  });

  test('optional update route keeps campaign data out of its location', () {
    final route = AppUpdateOptionalRoute($extra: campaign);

    expect(route.location, '/app-update/optional');
  });

  testWidgets('typed required route builds the required update page', (
    tester,
  ) async {
    final router = _router();
    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    unawaited(
      AppUpdateRequiredRoute($extra: campaign)
          .push(tester.element(find.text('Home'))),
    );
    await tester.pumpAndSettle();

    expect(find.text('Update required'), findsOneWidget);
  });

  testWidgets('typed optional route builds the optional update sheet', (
    tester,
  ) async {
    final router = _router();
    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    unawaited(
      AppUpdateOptionalRoute($extra: campaign)
          .push(tester.element(find.text('Home'))),
    );
    await tester.pumpAndSettle();

    expect(find.text('Maybe later'), findsOneWidget);
  });
}

GoRouter _router() {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Scaffold(body: Text('Home')),
      ),
      ...routes,
    ],
  );
}
