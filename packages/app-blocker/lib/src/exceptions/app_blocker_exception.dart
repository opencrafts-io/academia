/// Base exception for all app_blocker errors.
abstract class AppBlockerException implements Exception {
  /// Creates an [AppBlockerException].
  const AppBlockerException({required this.message, required this.code});

  /// Human-readable error message.
  final String message;

  /// Machine-readable error code.
  final String code;

  @override
  String toString() => '$runtimeType(code: $code, message: $message)';
}

/// Thrown when a required permission is denied.
class PermissionDeniedException extends AppBlockerException {
  /// Creates a [PermissionDeniedException].
  const PermissionDeniedException({
    super.message = 'Required permission was denied.',
    super.code = 'PERMISSION_DENIED',
  });
}

/// Thrown when permissions are restricted by the system or parental controls.
class PermissionRestrictedException extends AppBlockerException {
  /// Creates a [PermissionRestrictedException].
  const PermissionRestrictedException({
    super.message = 'Permission is restricted by system policy.',
    super.code = 'PERMISSION_RESTRICTED',
  });
}

/// Thrown when the blocking service is unavailable.
class ServiceUnavailableException extends AppBlockerException {
  /// Creates a [ServiceUnavailableException].
  const ServiceUnavailableException({
    super.message = 'Blocking service is unavailable.',
    super.code = 'SERVICE_UNAVAILABLE',
  });
}

/// Thrown when the current platform does not support the requested operation.
class PlatformUnsupportedException extends AppBlockerException {
  /// Creates a [PlatformUnsupportedException].
  const PlatformUnsupportedException({
    super.message = 'This operation is not supported on the current platform.',
    super.code = 'PLATFORM_UNSUPPORTED',
  });
}

/// Thrown when a schedule conflicts with an existing one.
class ScheduleConflictException extends AppBlockerException {
  /// Creates a [ScheduleConflictException].
  const ScheduleConflictException({
    super.message = 'Schedule conflicts with an existing schedule.',
    super.code = 'SCHEDULE_CONFLICT',
  });
}

/// Thrown when a referenced profile is not found.
class ProfileNotFoundException extends AppBlockerException {
  /// Creates a [ProfileNotFoundException].
  const ProfileNotFoundException({
    super.message = 'Profile not found.',
    super.code = 'PROFILE_NOT_FOUND',
  });
}

/// Thrown when an invalid configuration is provided.
class InvalidConfigException extends AppBlockerException {
  /// Creates an [InvalidConfigException].
  const InvalidConfigException({
    super.message = 'Invalid configuration provided.',
    super.code = 'INVALID_CONFIG',
  });
}
