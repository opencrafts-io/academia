import 'package:flutter_test/flutter_test.dart';

import 'package:app_blocker_example/main.dart';

void main() {
  testWidgets('App renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const AppBlockerExampleApp());

    expect(find.text('App Blocker Demo'), findsOneWidget);
    expect(find.text('Permissions'), findsOneWidget);
    expect(find.text('Block Apps'), findsOneWidget);
  });
}
