import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lock_in/lock_in.dart';

void main() {
  testWidgets('shows a blocked app and returns to Academia home', (
    tester,
  ) async {
    var returnedHome = false;

    await tester.pumpWidget(
      MaterialApp(
        home: LockInBlockedPage(
          appIdentifier: 'com.instagram.android',
          onReturnHome: () => returnedHome = true,
        ),
      ),
    );

    expect(find.text('This app is blocked'), findsOneWidget);
    expect(find.text('com.instagram.android'), findsOneWidget);

    await tester.tap(find.text('Return to Academia'));

    expect(returnedHome, isTrue);
  });

  testWidgets('handles the system Back action safely', (tester) async {
    var returnedHome = false;

    await tester.pumpWidget(
      MaterialApp(
        home: LockInBlockedPage(onReturnHome: () => returnedHome = true),
      ),
    );

    await tester.binding.handlePopRoute();

    expect(returnedHome, isTrue);
  });

  testWidgets('shows the saved rule and time remaining', (tester) async {
    final now = DateTime(2026, 9, 7, 10, 30);
    const rule = LockRule(
      id: 'work-hours',
      name: 'Work hours',
      apps: [
        BlockedApp(
          identifier: 'com.instagram.android',
          displayName: 'Instagram',
        ),
      ],
      weekdays: {DateTime.monday},
      startMinutes: 9 * 60,
      endMinutes: 17 * 60,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: LockInBlockedPage(
          appIdentifier: 'com.instagram.android',
          now: () => now,
          loadBlockWindow: (_, _) async => rule.activeWindowAt(now),
          onReturnHome: () {},
        ),
      ),
    );
    await tester.pump();

    expect(find.textContaining('Blocked by Academia'), findsOneWidget);
    expect(find.text('Work hours'), findsOneWidget);
    expect(find.text('6h 30m remaining'), findsOneWidget);
  });
}
