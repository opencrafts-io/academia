import 'app_blocker_platform_interface.dart';
import 'models/app_info.dart';
import 'models/block_event.dart';
import 'models/block_status.dart';
import 'models/blocker_capabilities.dart';
import 'models/block_screen_config.dart';
import 'models/permission_status.dart';
import 'models/profile.dart';
import 'models/schedule.dart';

/// Cross-platform app blocking plugin for Flutter.
///
/// Provides a unified API to block applications on both Android and iOS.
///
/// On Android, uses an AccessibilityService with a customizable block screen Activity to block apps.
/// On iOS, uses the Screen Time API (FamilyControls + ManagedSettings).
///
/// ```dart
/// final blocker = AppBlocker.instance;
///
/// // Check & request permissions
/// final status = await blocker.checkPermission();
/// if (status != BlockerPermissionStatus.granted) {
///   await blocker.requestPermission();
/// }
///
/// // Block specific apps
/// await blocker.blockApps(['com.instagram.android', 'com.twitter.android']);
///
/// // Listen to events
/// blocker.onBlockEvent.listen((event) {
///   print('${event.packageName}: ${event.type}');
/// });
/// ```
class AppBlocker {
  AppBlocker._();

  static final AppBlocker _instance = AppBlocker._();

  /// The singleton instance of [AppBlocker].
  static AppBlocker get instance => _instance;

  AppBlockerPlatform get _platform => AppBlockerPlatform.instance;

  // === Capabilities ===

  /// Returns the capabilities available on the current platform.
  ///
  /// Use this to check what features are available before calling them.
  Future<BlockerCapabilities> getCapabilities() {
    return _platform.getCapabilities();
  }

  // === Permissions ===

  /// Checks whether the required permissions are granted.
  ///
  /// On Android, checks Accessibility Service and query packages permissions.
  /// On iOS, checks FamilyControls authorization status.
  Future<BlockerPermissionStatus> checkPermission() {
    return _platform.checkPermission();
  }

  /// Requests the required permissions from the user.
  ///
  /// On Android, opens system settings for each required permission.
  /// On iOS, shows the FamilyControls authorization dialog.
  ///
  /// Throws [PermissionDeniedException] if the user denies all permissions.
  Future<BlockerPermissionStatus> requestPermission() {
    return _platform.requestPermission();
  }

  // === App Discovery ===

  /// Returns a list of available apps.
  ///
  /// On Android, returns all installed user apps with icons.
  /// On iOS, shows the FamilyActivityPicker and returns the selected apps.
  Future<List<AppInfo>> getApps() {
    return _platform.getApps();
  }

  // === Blocking ===

  /// Blocks the specified apps by their identifiers.
  ///
  /// On Android, uses the AccessibilityService to detect foreground apps and
  /// shows a full-screen block screen Activity for any of the specified apps.
  ///
  /// On iOS, applies shield restrictions via the Screen Time API.
  ///
  /// Throws [PermissionDeniedException] if permissions are not granted.
  Future<void> blockApps(List<String> appIdentifiers) {
    return _platform.blockApps(appIdentifiers);
  }

  /// Blocks all user applications.
  ///
  /// On Android, blocks all non-system apps.
  /// On iOS, applies shields to all app categories.
  Future<void> blockAll() {
    return _platform.blockAll();
  }

  /// Unblocks the specified apps.
  Future<void> unblockApps(List<String> appIdentifiers) {
    return _platform.unblockApps(appIdentifiers);
  }

  /// Stops all blocking.
  ///
  /// Deactivates the active profile (if any), disables all schedules, and
  /// stops any direct blocking started via [blockApps] or [blockAll].
  Future<void> unblockAll() {
    return _platform.unblockAll();
  }

  /// Returns the list of currently blocked app identifiers.
  Future<List<String>> getBlockedApps() {
    return _platform.getBlockedApps();
  }

  /// Returns the current block status of a specific app.
  Future<BlockStatus> getAppStatus(String appIdentifier) {
    return _platform.getAppStatus(appIdentifier);
  }

  // === Events ===

  /// A stream of block events.
  ///
  /// Emits events when apps are blocked, unblocked, or attempted to access.
  Stream<BlockEvent> get onBlockEvent => _platform.onBlockEvent;

  // === Block Screen Config (Android only) ===

  /// Configures the block screen shown when a blocked app is opened.
  ///
  /// This only has effect on Android. On iOS, the system shield is used.
  ///
  /// Throws [PlatformUnsupportedException] on iOS.
  Future<void> setBlockScreenConfig(BlockScreenConfig config) {
    return _platform.setBlockScreenConfig(config);
  }

  /// Returns the current block screen configuration, or `null` if none has been saved.
  ///
  /// This only has effect on Android.
  Future<BlockScreenConfig?> getBlockScreenConfig() {
    return _platform.getBlockScreenConfig();
  }

  // === Scheduling ===

  /// Adds a new blocking schedule.
  ///
  /// The schedule will automatically block the specified apps during
  /// the configured time windows.
  Future<void> addSchedule(BlockSchedule schedule) {
    return _platform.addSchedule(schedule);
  }

  /// Updates an existing schedule.
  Future<void> updateSchedule(BlockSchedule schedule) {
    return _platform.updateSchedule(schedule);
  }

  /// Removes a schedule.
  Future<void> removeSchedule(String scheduleId) {
    return _platform.removeSchedule(scheduleId);
  }

  /// Returns all configured schedules.
  Future<List<BlockSchedule>> getSchedules() {
    return _platform.getSchedules();
  }

  /// Enables a schedule.
  Future<void> enableSchedule(String scheduleId) {
    return _platform.enableSchedule(scheduleId);
  }

  /// Disables a schedule without removing it.
  Future<void> disableSchedule(String scheduleId) {
    return _platform.disableSchedule(scheduleId);
  }

  // === Profiles ===

  /// Creates a new blocking profile.
  ///
  /// A profile groups apps and schedules together for easy management.
  Future<void> createProfile(BlockProfile profile) {
    return _platform.createProfile(profile);
  }

  /// Updates an existing profile.
  Future<void> updateProfile(BlockProfile profile) {
    return _platform.updateProfile(profile);
  }

  /// Deletes a profile.
  Future<void> deleteProfile(String profileId) {
    return _platform.deleteProfile(profileId);
  }

  /// Returns all profiles.
  Future<List<BlockProfile>> getProfiles() {
    return _platform.getProfiles();
  }

  /// Activates a profile, blocking its configured apps.
  ///
  /// Only one profile can be active at a time. Activating a new profile
  /// will deactivate the previously active one.
  Future<void> activateProfile(String profileId) {
    return _platform.activateProfile(profileId);
  }

  /// Deactivates a profile, unblocking its apps.
  Future<void> deactivateProfile(String profileId) {
    return _platform.deactivateProfile(profileId);
  }

  /// Returns the currently active profile, or `null` if none is active.
  Future<BlockProfile?> getActiveProfile() {
    return _platform.getActiveProfile();
  }
}
