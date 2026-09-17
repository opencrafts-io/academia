import 'permission_capability.dart';
import 'permission_status.dart';

abstract interface class PermissionRequestObserver {
  void onPermissionRequested(
    PermissionCapability capability,
    PermissionStatus status,
  );
}

class NoopPermissionRequestObserver implements PermissionRequestObserver {
  const NoopPermissionRequestObserver();

  @override
  void onPermissionRequested(
    PermissionCapability capability,
    PermissionStatus status,
  ) {}
}
