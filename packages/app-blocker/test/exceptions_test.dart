import 'package:flutter_test/flutter_test.dart';
import 'package:app_blocker/app_blocker.dart';

void main() {
  // =========================================================================
  // PermissionDeniedException
  // =========================================================================

  group('PermissionDeniedException', () {
    test('has default code and message', () {
      const ex = PermissionDeniedException();
      expect(ex.code, 'PERMISSION_DENIED');
      expect(ex.message, 'Required permission was denied.');
    });

    test('accepts custom message', () {
      const ex = PermissionDeniedException(message: 'Custom denied');
      expect(ex.code, 'PERMISSION_DENIED');
      expect(ex.message, 'Custom denied');
    });

    test('toString matches expected format', () {
      const ex = PermissionDeniedException();
      expect(
        ex.toString(),
        'PermissionDeniedException(code: PERMISSION_DENIED, message: Required permission was denied.)',
      );
    });

    test('is an AppBlockerException', () {
      const ex = PermissionDeniedException();
      expect(ex, isA<AppBlockerException>());
    });
  });

  // =========================================================================
  // PermissionRestrictedException
  // =========================================================================

  group('PermissionRestrictedException', () {
    test('has default code and message', () {
      const ex = PermissionRestrictedException();
      expect(ex.code, 'PERMISSION_RESTRICTED');
      expect(ex.message, 'Permission is restricted by system policy.');
    });

    test('accepts custom message', () {
      const ex = PermissionRestrictedException(message: 'Parental controls');
      expect(ex.message, 'Parental controls');
    });

    test('toString matches expected format', () {
      const ex = PermissionRestrictedException();
      expect(
        ex.toString(),
        'PermissionRestrictedException(code: PERMISSION_RESTRICTED, message: Permission is restricted by system policy.)',
      );
    });

    test('is an AppBlockerException', () {
      const ex = PermissionRestrictedException();
      expect(ex, isA<AppBlockerException>());
    });
  });

  // =========================================================================
  // ServiceUnavailableException
  // =========================================================================

  group('ServiceUnavailableException', () {
    test('has default code and message', () {
      const ex = ServiceUnavailableException();
      expect(ex.code, 'SERVICE_UNAVAILABLE');
      expect(ex.message, 'Blocking service is unavailable.');
    });

    test('accepts custom message', () {
      const ex = ServiceUnavailableException(message: 'Crashed');
      expect(ex.message, 'Crashed');
    });

    test('toString matches expected format', () {
      const ex = ServiceUnavailableException();
      expect(
        ex.toString(),
        'ServiceUnavailableException(code: SERVICE_UNAVAILABLE, message: Blocking service is unavailable.)',
      );
    });
  });

  // =========================================================================
  // PlatformUnsupportedException
  // =========================================================================

  group('PlatformUnsupportedException', () {
    test('has default code and message', () {
      const ex = PlatformUnsupportedException();
      expect(ex.code, 'PLATFORM_UNSUPPORTED');
      expect(
        ex.message,
        'This operation is not supported on the current platform.',
      );
    });

    test('toString matches expected format', () {
      const ex = PlatformUnsupportedException();
      expect(ex.toString(), contains('PlatformUnsupportedException'));
      expect(ex.toString(), contains('PLATFORM_UNSUPPORTED'));
    });
  });

  // =========================================================================
  // ScheduleConflictException
  // =========================================================================

  group('ScheduleConflictException', () {
    test('has default code and message', () {
      const ex = ScheduleConflictException();
      expect(ex.code, 'SCHEDULE_CONFLICT');
      expect(ex.message, 'Schedule conflicts with an existing schedule.');
    });

    test('toString matches expected format', () {
      const ex = ScheduleConflictException();
      expect(ex.toString(), contains('ScheduleConflictException'));
      expect(ex.toString(), contains('SCHEDULE_CONFLICT'));
    });
  });

  // =========================================================================
  // ProfileNotFoundException
  // =========================================================================

  group('ProfileNotFoundException', () {
    test('has default code and message', () {
      const ex = ProfileNotFoundException();
      expect(ex.code, 'PROFILE_NOT_FOUND');
      expect(ex.message, 'Profile not found.');
    });

    test('toString matches expected format', () {
      const ex = ProfileNotFoundException();
      expect(ex.toString(), contains('ProfileNotFoundException'));
      expect(ex.toString(), contains('PROFILE_NOT_FOUND'));
    });
  });

  // =========================================================================
  // InvalidConfigException
  // =========================================================================

  group('InvalidConfigException', () {
    test('has default code and message', () {
      const ex = InvalidConfigException();
      expect(ex.code, 'INVALID_CONFIG');
      expect(ex.message, 'Invalid configuration provided.');
    });

    test('accepts custom message', () {
      const ex = InvalidConfigException(message: 'Bad overlay');
      expect(ex.message, 'Bad overlay');
      expect(ex.code, 'INVALID_CONFIG');
    });

    test('toString matches expected format', () {
      const ex = InvalidConfigException();
      expect(ex.toString(), contains('InvalidConfigException'));
      expect(ex.toString(), contains('INVALID_CONFIG'));
    });
  });

  // =========================================================================
  // AppBlockerException is abstract
  // =========================================================================

  group('AppBlockerException', () {
    test('cannot be instantiated directly (is abstract)', () {
      // Verify that all concrete exception types are subtypes of
      // AppBlockerException while AppBlockerException itself is abstract.
      // Dart does not allow instantiating an abstract class, so we confirm
      // the type hierarchy rather than trying to call the constructor.
      expect(const PermissionDeniedException(), isA<AppBlockerException>());
      expect(const PermissionRestrictedException(), isA<AppBlockerException>());
      expect(const ServiceUnavailableException(), isA<AppBlockerException>());
      expect(const PlatformUnsupportedException(), isA<AppBlockerException>());
      expect(const ScheduleConflictException(), isA<AppBlockerException>());
      expect(const ProfileNotFoundException(), isA<AppBlockerException>());
      expect(const InvalidConfigException(), isA<AppBlockerException>());
    });

    test('all exceptions implement Exception interface', () {
      const exceptions = <AppBlockerException>[
        PermissionDeniedException(),
        PermissionRestrictedException(),
        ServiceUnavailableException(),
        PlatformUnsupportedException(),
        ScheduleConflictException(),
        ProfileNotFoundException(),
        InvalidConfigException(),
      ];

      for (final ex in exceptions) {
        expect(ex, isA<Exception>());
      }
    });

    test('toString format is consistent across all exception types', () {
      const exceptions = <AppBlockerException>[
        PermissionDeniedException(),
        PermissionRestrictedException(),
        ServiceUnavailableException(),
        PlatformUnsupportedException(),
        ScheduleConflictException(),
        ProfileNotFoundException(),
        InvalidConfigException(),
      ];

      for (final ex in exceptions) {
        final str = ex.toString();
        // Format: RuntimeType(code: CODE, message: MESSAGE)
        expect(str, contains('code:'));
        expect(str, contains('message:'));
        expect(str, contains(ex.code));
        expect(str, contains(ex.message));
      }
    });
  });
}
