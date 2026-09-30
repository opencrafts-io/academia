import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:pub_semver/pub_semver.dart';

void main() {
  final campaign = UpdateCampaign(
    id: 'required-update',
    targetVersion: Version.parse('3.4.0'),
    mode: AppUpdateMode.required,
    title: 'Update required',
    message: 'Install the supported release.',
    storeUrl: Uri.parse(
      'https://play.google.com/store/apps/details?id=io.opencrafts.academia',
    ),
  );

  testWidgets('required prompt displays its copy and invokes update action', (
    tester,
  ) async {
    var updateRequested = false;

    await tester.pumpWidget(
      MaterialApp(
        home: AppUpdateRequiredPage(
          campaign: campaign,
          onUpdate: () => updateRequested = true,
        ),
      ),
    );

    expect(find.text('Update required'), findsOneWidget);
    expect(find.text('Install the supported release.'), findsOneWidget);

    await tester.tap(find.text('Get the new version'));

    expect(updateRequested, isTrue);
  });

  testWidgets('optional prompt offers a dismiss action', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppUpdateOptionalSheet(campaign: campaign, onUpdate: () {}),
        ),
      ),
    );

    expect(find.text('Maybe later'), findsOneWidget);
    expect(find.text('Get the new version'), findsOneWidget);
  });

  testWidgets('required prompt cannot be dismissed by system back', (
    tester,
  ) async {
    final navigatorKey = GlobalKey<NavigatorState>();

    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigatorKey,
        home: const Scaffold(body: Text('Home')),
      ),
    );
    navigatorKey.currentState!.push(
      MaterialPageRoute<void>(
        builder: (_) =>
            AppUpdateRequiredPage(campaign: campaign, onUpdate: () {}),
      ),
    );
    await tester.pumpAndSettle();

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(find.text('Update required'), findsOneWidget);
  });
}
