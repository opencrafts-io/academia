import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lock_in/lock_in.dart';

void main() {
  testWidgets('renders an accessible local blocked-attempt summary', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AttemptHeatmap(
            counts: {DateTime(2026, 9, 7): 3},
            weeks: 1,
            endDate: DateTime(2026, 9, 7),
          ),
        ),
      ),
    );

    expect(
      find.bySemanticsLabel('3 blocked attempts on September 7, 2026'),
      findsOneWidget,
    );
  });
}
