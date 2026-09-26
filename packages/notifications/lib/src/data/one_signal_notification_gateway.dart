import 'dart:async';

import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../application/notification_action_handler.dart';
import '../application/notification_identity_service.dart';
import '../application/notification_initializer.dart';
import '../domain/notification_action.dart';
import '../domain/notification_identity.dart';

class OneSignalNotificationGateway
    implements NotificationInitializer, NotificationIdentityService {
  OneSignalNotificationGateway(this._appId);

  static NotificationActionHandler? _actionHandler;

  final String _appId;
  var _isInitialized = false;

  @override
  Future<void> initialize(NotificationActionHandler actionHandler) async {
    _actionHandler = actionHandler;
    if (_isInitialized) {
      return;
    }

    await OneSignal.initialize(_appId);
    OneSignal.Notifications.addClickListener(_onClick);
    OneSignal.Notifications.addForegroundWillDisplayListener(
      (event) => event.notification.display(),
    );
    _isInitialized = true;
  }

  @override
  Future<void> identify(NotificationIdentity identity) async {
    try {
      await OneSignal.login(identity.userId);
      await OneSignal.User.addEmail(identity.email);
      await OneSignal.User.addAliases({'name': identity.displayName});
      if (identity.phoneNumber case final phoneNumber?
          when phoneNumber.trim().isNotEmpty) {
        await OneSignal.User.addSms(phoneNumber);
      }
    } catch (_) {
      // Push identity must not block a successful account operation.
    }
  }

  @override
  Future<void> clear() async {
    try {
      await OneSignal.logout();
    } catch (_) {
      // Push identity is best-effort when the provider is unavailable.
    }
  }

  static void _onClick(OSNotificationClickEvent event) {
    final handler = _actionHandler;
    if (handler == null) {
      return;
    }
    unawaited(
      handler.handle(
        NotificationAction.fromPayload(
          buttonKey: event.result.actionId,
          payload: event.notification.additionalData,
        ),
      ),
    );
  }
}
