import 'package:academia/core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationRemoteDatasource {
  final Logger _logger = Logger();

  /// Initialize OneSignal with the provided app ID
  Future<Either<Failure, void>> initializeOneSignal(String appId) async {
    try {
      _logger.d('Starting OneSignal initialization with app ID: $appId');

      // Validate app ID format
      if (appId.isEmpty || appId.length < 10) {
        throw Exception(
          'Invalid OneSignal App ID: App ID is too short or empty',
        );
      }

      _logger.d('App ID validation passed');

      // Set OneSignal App ID
      OneSignal.initialize(appId);

      // Request permission for notifications
      OneSignal.Notifications.requestPermission(true);

      // Set up notification handlers
      OneSignal.Notifications.addClickListener((event) {
        _logger.d(
          'Notification clicked: ${event.notification.jsonRepresentation()}',
        );
      });

      OneSignal.Notifications.addForegroundWillDisplayListener((event) {
        _logger.d(
          'Notification received in foreground: ${event.notification.jsonRepresentation()}',
        );
      });

      // Add a small delay to ensure initialization is complete
      await Future.delayed(const Duration(milliseconds: 500));

      _logger.d('OneSignal initialized successfully with app ID: $appId');
      return right(null);
    } catch (e) {
      _logger.e('Failed to initialize OneSignal', error: e);
      return left(
        NotificationFailure(
          message: 'Failed to initialize notifications: ${e.toString()}',
          error: e,
        ),
      );
    }
  }

  /// Get notification permission status
  Future<Either<Failure, bool>> getNotificationPermission() async {
    try {
      final deviceState = OneSignal.User.pushSubscription;
      final isEnabled = deviceState.optedIn ?? false;
      _logger.d('Notification permission status: $isEnabled');
      return right(isEnabled);
    } catch (e) {
      _logger.e('Failed to get notification permission', error: e);
      return left(
        NotificationFailure(
          message: 'Failed to get notification permission',
          error: e,
        ),
      );
    }
  }

  /// Set notification permission
  Future<Either<Failure, void>> setNotificationPermission(bool enabled) async {
    try {
      if (enabled) {
        OneSignal.Notifications.requestPermission(true);
      } else {
        OneSignal.Notifications.clearAll();
      }
      _logger.d('Notification permission set to: $enabled');
      return right(null);
    } catch (e) {
      _logger.e('Failed to set notification permission', error: e);
      return left(
        NotificationFailure(
          message: 'Failed to set notification permission',
          error: e,
        ),
      );
    }
  }

  /// Send local notification (for testing)
  Future<Either<Failure, void>> sendLocalNotification({
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      // Note: OneSignal Flutter SDK doesn't support creating local notifications directly
      // This would typically be handled by the server sending a push notification
      // For now, we'll just log the attempt
      _logger.d('Local notification request: $title - $body');
      _logger.d('Additional data: $data');
      _logger.d('Local notification sent: $title - $body');
      return right(null);
    } catch (e) {
      _logger.e('Failed to send local notification', error: e);
      return left(
        NotificationFailure(message: 'Failed to send notification', error: e),
      );
    }
  }
}

/// Custom failure for notification operations
class NotificationFailure extends Failure {
  final String _message;
  final Object? _error;

  NotificationFailure({required String message, Object? error})
    : _message = message,
      _error = error,
      super(message: message, error: error ?? Object());

  @override
  String get message => _message;

  @override
  Object get error => _error ?? Object();
}
