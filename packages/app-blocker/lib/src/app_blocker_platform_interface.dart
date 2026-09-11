import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'app_blocker_method_channel.dart';
import 'models/app_info.dart';
import 'models/block_event.dart';
import 'models/block_status.dart';
import 'models/blocker_capabilities.dart';
import 'models/block_screen_config.dart';
import 'models/permission_status.dart';
import 'models/profile.dart';
import 'models/schedule.dart';

/// The interface that platform-specific implementations must implement.
abstract class AppBlockerPlatform extends PlatformInterface {
  /// Constructs an [AppBlockerPlatform].
  AppBlockerPlatform() : super(token: _token);

  static final Object _token = Object();

  static AppBlockerPlatform _instance = MethodChannelAppBlocker();

  /// The default instance of [AppBlockerPlatform] to use.
  static AppBlockerPlatform get instance => _instance;

  /// Platform-specific implementations should set this to their own
  /// platform-specific class that extends [AppBlockerPlatform].
  static set instance(AppBlockerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  // -- Capabilities --

  /// Returns the capabilities of the current platform.
  Future<BlockerCapabilities> getCapabilities() {
    throw UnimplementedError('getCapabilities() has not been implemented.');
  }

  // -- Permissions --

  /// Checks the current permission status.
  Future<BlockerPermissionStatus> checkPermission() {
    throw UnimplementedError('checkPermission() has not been implemented.');
  }

  /// Requests the required permissions.
  Future<BlockerPermissionStatus> requestPermission() {
    throw UnimplementedError('requestPermission() has not been implemented.');
  }

  // -- App Discovery --

  /// Returns a list of apps.
  ///
  /// On Android, returns all installed user apps.
  /// On iOS, shows the FamilyActivityPicker and returns the selected apps.
  Future<List<AppInfo>> getApps() {
    throw UnimplementedError('getApps() has not been implemented.');
  }

  // -- Blocking --

  /// Blocks the specified apps.
  Future<void> blockApps(List<String> appIdentifiers) {
    throw UnimplementedError('blockApps() has not been implemented.');
  }

  /// Blocks all apps.
  Future<void> blockAll() {
    throw UnimplementedError('blockAll() has not been implemented.');
  }

  /// Unblocks the specified apps.
  Future<void> unblockApps(List<String> appIdentifiers) {
    throw UnimplementedError('unblockApps() has not been implemented.');
  }

  /// Unblocks all apps.
  Future<void> unblockAll() {
    throw UnimplementedError('unblockAll() has not been implemented.');
  }

  /// Returns the list of currently blocked app identifiers.
  Future<List<String>> getBlockedApps() {
    throw UnimplementedError('getBlockedApps() has not been implemented.');
  }

  /// Returns the block status of a specific app.
  Future<BlockStatus> getAppStatus(String appIdentifier) {
    throw UnimplementedError('getAppStatus() has not been implemented.');
  }

  // -- Events --

  /// Stream of block events.
  Stream<BlockEvent> get onBlockEvent {
    throw UnimplementedError('onBlockEvent has not been implemented.');
  }

  // -- Block Screen Config (Android only) --

  /// Sets the block screen configuration for the Android block screen.
  Future<void> setBlockScreenConfig(BlockScreenConfig config) {
    throw UnimplementedError(
      'setBlockScreenConfig() has not been implemented.',
    );
  }

  /// Returns the current block screen configuration. Returns null if none has been saved.
  Future<BlockScreenConfig?> getBlockScreenConfig() {
    throw UnimplementedError(
      'getBlockScreenConfig() has not been implemented.',
    );
  }

  // -- Scheduling --

  /// Adds a new schedule.
  Future<void> addSchedule(BlockSchedule schedule) {
    throw UnimplementedError('addSchedule() has not been implemented.');
  }

  /// Updates an existing schedule.
  Future<void> updateSchedule(BlockSchedule schedule) {
    throw UnimplementedError('updateSchedule() has not been implemented.');
  }

  /// Removes a schedule by ID.
  Future<void> removeSchedule(String scheduleId) {
    throw UnimplementedError('removeSchedule() has not been implemented.');
  }

  /// Returns all schedules.
  Future<List<BlockSchedule>> getSchedules() {
    throw UnimplementedError('getSchedules() has not been implemented.');
  }

  /// Enables a schedule.
  Future<void> enableSchedule(String scheduleId) {
    throw UnimplementedError('enableSchedule() has not been implemented.');
  }

  /// Disables a schedule.
  Future<void> disableSchedule(String scheduleId) {
    throw UnimplementedError('disableSchedule() has not been implemented.');
  }

  // -- Profiles --

  /// Creates a new profile.
  Future<void> createProfile(BlockProfile profile) {
    throw UnimplementedError('createProfile() has not been implemented.');
  }

  /// Updates an existing profile.
  Future<void> updateProfile(BlockProfile profile) {
    throw UnimplementedError('updateProfile() has not been implemented.');
  }

  /// Deletes a profile by ID.
  Future<void> deleteProfile(String profileId) {
    throw UnimplementedError('deleteProfile() has not been implemented.');
  }

  /// Returns all profiles.
  Future<List<BlockProfile>> getProfiles() {
    throw UnimplementedError('getProfiles() has not been implemented.');
  }

  /// Activates a profile.
  Future<void> activateProfile(String profileId) {
    throw UnimplementedError('activateProfile() has not been implemented.');
  }

  /// Deactivates a profile.
  Future<void> deactivateProfile(String profileId) {
    throw UnimplementedError('deactivateProfile() has not been implemented.');
  }

  /// Returns the currently active profile, or null.
  Future<BlockProfile?> getActiveProfile() {
    throw UnimplementedError('getActiveProfile() has not been implemented.');
  }
}
