import '../application/permission_status.dart';

/// A system dialog can still be shown only while the user can respond to it.
bool shouldPromptForNotificationOnLaunch(PermissionStatus status) =>
    status == PermissionStatus.denied;
