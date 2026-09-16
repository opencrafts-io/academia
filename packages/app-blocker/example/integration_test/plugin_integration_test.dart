import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:app_blocker/app_blocker.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('checkPermission returns a valid status', (
    WidgetTester tester,
  ) async {
    final blocker = AppBlocker.instance;
    final status = await blocker.checkPermission();
    expect(BlockerPermissionStatus.values.contains(status), true);
  });
}
