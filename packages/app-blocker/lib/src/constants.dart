/// Channel and method name constants for platform communication.
class AppBlockerConstants {
  AppBlockerConstants._();

  /// The method channel name.
  static const String methodChannel = 'com.khanhtq.app_blocker/methods';

  /// The event channel name for block events.
  static const String eventChannel = 'com.khanhtq.app_blocker/events';

  // -- Method names --

  /// Method name for getting platform capabilities.
  static const String getCapabilities = 'getCapabilities';

  /// Method name for checking permission status.
  static const String checkPermission = 'checkPermission';

  /// Method name for requesting permissions.
  static const String requestPermission = 'requestPermission';

  /// Method name for getting installed apps.
  static const String getApps = 'getApps';

  /// Method name for blocking specific apps.
  static const String blockApps = 'blockApps';

  /// Method name for blocking all apps.
  static const String blockAll = 'blockAll';

  /// Method name for unblocking specific apps.
  static const String unblockApps = 'unblockApps';

  /// Method name for unblocking all apps.
  static const String unblockAll = 'unblockAll';

  /// Method name for getting blocked apps list.
  static const String getBlockedApps = 'getBlockedApps';

  /// Method name for getting a specific app's block status.
  static const String getAppStatus = 'getAppStatus';

  /// Method name for setting block screen configuration.
  static const String setBlockScreenConfig = 'setBlockScreenConfig';

  /// Method name for getting block screen configuration.
  static const String getBlockScreenConfig = 'getBlockScreenConfig';

  /// Method name for adding a blocking schedule.
  static const String addSchedule = 'addSchedule';

  /// Method name for updating an existing schedule.
  static const String updateSchedule = 'updateSchedule';

  /// Method name for removing a schedule.
  static const String removeSchedule = 'removeSchedule';

  /// Method name for getting all schedules.
  static const String getSchedules = 'getSchedules';

  /// Method name for enabling a schedule.
  static const String enableSchedule = 'enableSchedule';

  /// Method name for disabling a schedule.
  static const String disableSchedule = 'disableSchedule';

  /// Method name for creating a blocking profile.
  static const String createProfile = 'createProfile';

  /// Method name for updating an existing profile.
  static const String updateProfile = 'updateProfile';

  /// Method name for deleting a profile.
  static const String deleteProfile = 'deleteProfile';

  /// Method name for getting all profiles.
  static const String getProfiles = 'getProfiles';

  /// Method name for activating a profile.
  static const String activateProfile = 'activateProfile';

  /// Method name for deactivating a profile.
  static const String deactivateProfile = 'deactivateProfile';

  /// Method name for getting the active profile.
  static const String getActiveProfile = 'getActiveProfile';

  // -- Error codes --

  /// Error code when user denies required permission.
  static const String errorPermissionDenied = 'PERMISSION_DENIED';

  /// Error code when permission is restricted by system or parental controls.
  static const String errorPermissionRestricted = 'PERMISSION_RESTRICTED';

  /// Error code when the blocking service is unavailable.
  static const String errorServiceUnavailable = 'SERVICE_UNAVAILABLE';

  /// Error code when a feature is not supported on the current platform.
  static const String errorPlatformUnsupported = 'PLATFORM_UNSUPPORTED';

  /// Error code when a schedule conflicts with an existing one.
  static const String errorScheduleConflict = 'SCHEDULE_CONFLICT';

  /// Error code when a referenced profile is not found.
  static const String errorProfileNotFound = 'PROFILE_NOT_FOUND';

  /// Error code when an invalid configuration is provided.
  static const String errorInvalidConfig = 'INVALID_CONFIG';
}
