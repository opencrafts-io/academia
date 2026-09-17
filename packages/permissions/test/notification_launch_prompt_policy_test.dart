import 'package:flutter_test/flutter_test.dart';
import 'package:permissions/permissions.dart';

void main() {
  test('prompts on launch only while notifications are requestable', () {
    expect(
      shouldPromptForNotificationOnLaunch(PermissionStatus.denied),
      isTrue,
    );
    expect(
      shouldPromptForNotificationOnLaunch(PermissionStatus.granted),
      isFalse,
    );
    expect(
      shouldPromptForNotificationOnLaunch(PermissionStatus.permanentlyDenied),
      isFalse,
    );
  });
}
