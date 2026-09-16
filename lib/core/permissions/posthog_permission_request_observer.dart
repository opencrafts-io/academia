import 'package:permissions/permissions.dart';
import 'package:posthog_flutter/posthog_flutter.dart';

class PosthogPermissionRequestObserver implements PermissionRequestObserver {
  PosthogPermissionRequestObserver({Posthog? posthog})
    : _posthog = posthog ?? Posthog();

  final Posthog _posthog;

  @override
  void onPermissionRequested(
    PermissionCapability capability,
    PermissionStatus status,
  ) {
    _posthog.capture(
      eventName: 'permission_request',
      properties: {'permission': capability.name, 'status': status.name},
    );
  }
}
