# Permissions

This private package owns Academia's runtime-permission policy, platform
adapter, permission state, and notification permission screen. Application code
uses its typed capabilities rather than importing `permission_handler`.

## Configure the host

Add the package as a path dependency, then configure it once at the host's
composition root. Supplying an observer is optional; use one when permission
requests should be recorded by host-owned analytics.

```dart
import 'package:get_it/get_it.dart';
import 'package:permissions/permissions.dart';

configurePermissionsDependencies(
  GetIt.instance,
  permissionRequestObserver: MyPermissionRequestObserver(),
);
```

Without an observer, the package uses a no-op implementation. The host keeps
native permission declarations in its Android and iOS project configuration.

## Check and request a permission

Provide the registered `PermissionCubit` to the relevant widget subtree, then
use `PermissionCapability` values for all checks and requests:

```dart
final permissions = <PermissionCapability>[
  PermissionCapability.notifications,
];

final cubit = GetIt.instance<PermissionCubit>();
await cubit.checkAll(permissions);

if (cubit.state is PermissionDenied) {
  await cubit.request(PermissionCapability.notifications);
}

if (cubit.state is PermissionPermanentlyDenied) {
  await cubit.openSystemSettings();
}
```

Use `check` for one capability and `checkAll` when a feature needs several.
`checkAll` emits a permanent denial when any capability is permanently denied,
a grant when all are granted, and a denial otherwise.

The supported capabilities are `location`, `notifications`, `camera`,
`storage`, and `preciseAlarms`. Only request the capabilities needed for the
current feature; `preciseAlarms` is Android-specific.

## Notification screen and route

The package provides the notification permission prompt and its typed route:

```dart
NotificationPermissionRoute().push(context);
```

Keep direct imports of `permission_handler` inside this package. New product
code should use `PermissionCubit`, `PermissionCapability`, and
`PermissionState` from `package:permissions/permissions.dart`.

## Development

```bash
flutter test
dart run build_runner build
```
