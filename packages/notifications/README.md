# Notifications

This private package owns Academia's notification SDK integrations. Feature
code must use its typed interfaces; it must not import OneSignal or Awesome
Notifications directly.

`LocalNotificationScheduler` delivers local reminders. `NotificationIdentityService`
links the signed-in account to OneSignal. `NotificationService` initializes both
once during dependency setup.

## Use it in the app

The application root configures this package. Features receive a
`LocalNotificationScheduler` through dependency injection:

```dart
await scheduler.schedule(
  LocalNotificationRequest(
    id: reminderId,
    channel: LocalNotificationChannel.reminders,
    title: 'Due tomorrow',
    body: todo.title,
    schedule: LocalNotificationSchedule.at(due, precise: true),
    payload: {'localId': todo.localId.toString()},
  ),
);
```

Use `cancel(id)` for one reminder and `cancelAllSchedules()` only for an
intentional complete reset. Actions and payload values are typed strings. The
host app handles only known destinations; do not add URL-based routing to a
notification payload.

Notification permission is intentionally separate from delivery. Request it
through the `permissions` package from Settings or the launch prompt, so a user
can enable it later from app or system settings.

## Platform behavior

| Target | Behavior |
| --- | --- |
| Android and iOS | OneSignal push and Awesome local delivery are initialized. |
| Web, desktop, and unsupported targets | Disabled implementations safely no-op. |

Use open actions for actions that touch app state. A silent iOS action needs a
native plugin registrant and a safe background-isolate bootstrap before it can
access app services.

## Native checklist

- Android declares `POST_NOTIFICATIONS` and `SCHEDULE_EXACT_ALARM` in the app
  manifest. Verify FCM credentials for each release flavor in OneSignal; do not
  add a placeholder project number to the manifest.
- iOS keeps the push entitlement, `remote-notification` background mode, and
  the OneSignal Notification Service Extension. Verify signing for the app and
  extension together on a physical device.
- Initialize this package once. Awesome Notifications warns that multiple local
  notification SDK initializations can compete for platform resources.

See the [OneSignal Flutter setup guide](https://documentation.onesignal.com/docs/en/flutter-sdk-setup)
and [Awesome Notifications package documentation](https://pub.dev/packages/awesome_notifications)
before changing native setup.

## Verification

```sh
flutter test packages/notifications/test/notification_contract_test.dart
flutter test test/core/notification_sdk_boundary_test.dart
flutter test test/core/notification_native_configuration_test.dart
```
