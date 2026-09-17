# app_blocker

A cross-platform Flutter plugin for **app blocking**, **parental controls**, and **digital wellbeing**. Block apps with a customizable block screen on Android and Screen Time Shield on iOS. Supports time-based scheduling, focus profiles, and real-time block event streams.

## Features

- **Block & unblock apps** — Block specific apps or all apps at once on both Android and iOS
- **Custom block screen** (Android) — Fully customizable block screen with title, subtitle, message, background color, and icon
- **Screen Time Shield** (iOS) — Native iOS Screen Time integration via FamilyControls and ManagedSettings
- **Time-based scheduling** (Android) — Schedule app blocking by weekday and time range, with boot persistence
- **Focus profiles** — Group apps into reusable profiles (e.g., "Work Mode", "Sleep Mode") for quick activation
- **Real-time events** — Stream of block/unblock/schedule events for monitoring and analytics
- **Permission management** — Simple API for checking and requesting platform permissions
- **Boot persistence** — Blocking rules and schedules survive device restarts

## Getting Started

### Installation

Add `app_blocker` to your `pubspec.yaml`:

```yaml
dependencies:
  app_blocker: ^2.2.0
```

**Requires Flutter 3.44 / Dart 3.12 or newer.** On earlier Flutter versions, use `app_blocker: ^2.1.0`.

### Android Setup

**Minimum SDK:** 24 (Android 7.0)

No additional setup required. The plugin automatically adds these permissions:

- `SCHEDULE_EXACT_ALARM` — Time-based blocking (requires `requestPermission()`, might get auto-granted on Android 12 & 13 ([source](https://developer.android.com/about/versions/14/changes/schedule-exact-alarms)))
- `QUERY_ALL_PACKAGES` — List installed apps
- `RECEIVE_BOOT_COMPLETED` — Restore schedules after reboot

During runtime, by calling `requestPermission()`, the user will be prompted to grant:
- SCHEDULE_EXACT_ALARM (if not auto-granted)
- Accessibility Service permission (opens system settings)

### iOS Setup

**Minimum iOS:** 16.0

1. Open `ios/Runner.xcworkspace` in Xcode
2. Runner target > **Signing & Capabilities** > add **Family Controls**
3. Set deployment target in `ios/Podfile`:

```ruby
platform :ios, '16.0'
```

### Quick Start

```dart
import 'package:app_blocker/app_blocker.dart';

final blocker = AppBlocker.instance;

// 1. Request permission
await blocker.requestPermission();

// 2. Block apps
await blocker.blockAll();

// 3. Listen to events
blocker.onBlockEvent.listen((event) {
  print('${event.type}: ${event.packageName}');
});
```

## Usage

### Permission

```dart
// Check permission status
final status = await blocker.checkPermission();
// Returns: BlockerPermissionStatus.granted / .denied / .restricted

// Request permission (opens system settings on Android, shows dialog on iOS)
// must be called multiple times on Android until all permissions are granted
await blocker.requestPermission();
```

### Get Apps & Block

**Android:**

```dart
// Get all installed apps (returns list with appName, packageName, icon)
final apps = await blocker.getApps();

// Block using package names
await blocker.blockApps(apps.map((a) => a.packageName).toList());
```

**iOS:**

```dart
// Opens FamilyActivityPicker — user selects apps → automatically blocked
await blocker.getApps();
```

**Common:**

```dart
await blocker.blockAll();
await blocker.unblockAll();
final blocked = await blocker.getBlockedApps();
```

### Block Screen Config (Android only)

```dart
await blocker.setBlockScreenConfig(
  const BlockScreenConfig(
    title: 'Stay Focused!',
    subtitle: 'This app is blocked',
    message: 'Get back to work.',
    backgroundColor: Color(0xDD000000),
  ),
);
// iOS uses the system Screen Time Shield automatically
```

### Schedules (Android only)

```dart
// Recurring schedule (repeats on specified weekdays)
await blocker.addSchedule(BlockSchedule(
  id: 'work-hours',
  name: 'Work Hours',
  appIdentifiers: ['com.instagram.android'],
  weekdays: [1, 2, 3, 4, 5], // Mon-Fri (ISO 8601)
  startTime: const TimeOfDay(hour: 9, minute: 0),
  endTime: const TimeOfDay(hour: 17, minute: 0),
));

// One-time schedule (runs once on specific date, auto-disables after)
// await blocker.addSchedule(BlockSchedule(
//   id: 'temp-${DateTime.now().millisecondsSinceEpoch}',
//   name: 'Short Break',
//   appIdentifiers: ['com.instagram.android'],
//   startTime: const TimeOfDay(hour: 14, minute: 0),
//   endTime: const TimeOfDay(hour: 14, minute: 15),
//   scheduleDate: DateTime.now(), // Today only
// ));

await blocker.enableSchedule('work-hours');
await blocker.disableSchedule('work-hours');
await blocker.removeSchedule('work-hours');
final schedules = await blocker.getSchedules();
```

> **Note:** Scheduling is not supported on iOS (`canSchedule` returns `false`). iOS lacks the background execution mechanism needed to enforce time-based blocking reliably without the DeviceActivity framework (not yet integrated).

### Profiles

```dart
// Create a profile grouping apps to block together
await blocker.createProfile(BlockProfile(
  id: 'social-media',
  name: 'Social Media',
  appIdentifiers: ['com.instagram.android', 'com.twitter.android'],
));

// Activate (blocks the profile's apps); deactivates any previously active profile
await blocker.activateProfile('social-media');
await blocker.deactivateProfile('social-media');

final profiles = await blocker.getProfiles();
final active = await blocker.getActiveProfile(); // null if none active
```

### Block Events

```dart
blocker.onBlockEvent.listen((event) {
  print('${event.type}: ${event.packageName}');
});
// Event types: blocked, unblocked, attemptedAccess,
//              scheduleActivated, scheduleDeactivated
```

### Capabilities

```dart
// Check what features are available on current platform
final caps = await blocker.getCapabilities();
```

## Supported Functions

**Permissions & capabilities**
- `checkPermission()` — Check if required permissions are granted
- `requestPermission()` — Request permissions from user
- `getCapabilities()` — Check which features are available on the current platform

**App discovery**
- `getApps()` — List installed apps (Android) or show FamilyActivityPicker (iOS)

**Blocking**
- `blockApps(List<String>)` — Block specific apps
- `blockAll()` — Block all apps
- `unblockApps(List<String>)` — Unblock specific apps
- `unblockAll()` — Unblock all apps
- `getBlockedApps()` — List currently blocked app identifiers
- `getAppStatus(String)` — Get block status of a specific app
- `setBlockScreenConfig(BlockScreenConfig)` — Customize the block screen (Android only)
- `getBlockScreenConfig()` — Get current block screen configuration (Android only)

**Schedules (Android only)**
- `addSchedule(BlockSchedule)` — Add a time-based blocking schedule
- `updateSchedule(BlockSchedule)` — Update an existing schedule
- `removeSchedule(String)` — Remove a schedule
- `getSchedules()` — List all schedules
- `enableSchedule(String)` — Enable a schedule
- `disableSchedule(String)` — Disable a schedule without removing it

**Profiles**
- `createProfile(BlockProfile)` — Create a profile grouping apps to block together
- `updateProfile(BlockProfile)` — Update an existing profile
- `deleteProfile(String)` — Delete a profile
- `getProfiles()` — List all profiles
- `activateProfile(String)` — Activate a profile (blocks its apps)
- `deactivateProfile(String)` — Deactivate a profile
- `getActiveProfile()` — Get the currently active profile

**Events**
- `onBlockEvent` — Stream of block/unblock/schedule events

## Platform Support

| Feature              | Android | iOS |
|----------------------|---------|-----|
| Block / Unblock apps | ✅      | ✅  |
| Block all apps       | ✅      | ✅  |
| Get installed apps   | ✅      | -   |
| Custom block screen  | ✅      | -   |
| Screen Time Shield   | -       | ✅  |
| Schedules            | ✅      | -   |
| Profiles             | ✅      | ✅  |
| Block events stream  | ✅      | ✅  |
| Boot persistence     | ✅      | ✅  |

## Example

See the [example app](https://github.com/tranquockhanh0506/app_blocker/tree/master/example) for a complete working demo with tabs for blocking, schedules, profiles, and event monitoring.

## Additional Information

### Contributing

Contributions are welcome! Please open an issue or submit a pull request on [GitHub](https://github.com/tranquockhanh0506/app_blocker).

### Filing Issues

If you encounter a bug or have a feature request, please file an issue on the [issue tracker](https://github.com/tranquockhanh0506/app_blocker/issues).

### License

MIT — see [LICENSE](LICENSE).
