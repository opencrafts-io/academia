import 'package:academia/core/core.dart';
import 'package:academia/features/notifications/notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDatasource remoteDatasource;
  final NotificationLocalDatasource localDatasource;

  NotificationRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<Either<Failure, void>> initializeLocalNotifications(
    List<NotificationChannelConfig> channels,
  ) async {
    final notificationChannels = channels
        .map((config) => config.toNotificationChannel())
        .toList();

    try {
      final initialized = await AwesomeNotifications().initialize(
        "resource://drawable/academia",
        notificationChannels,
        debug: kDebugMode,
      );

      if (!initialized) {
        return left(
          NotificationFailure(
            message: "Failed to initialize local notifications",
            error: initialized,
          ),
        );
      }

      return right(null);
    } catch (error) {
      return left(
        NotificationFailure(
          message: "Failed to initialize local notifications",
          error: error,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> initializeOneSignal(String appId) async {
    return await remoteDatasource.initializeOneSignal(appId);
  }

  @override
  Future<Either<Failure, void>> setUserData({
    required String userId,
    required String name,
    required String email,
  }) async {
    return await remoteDatasource.setUserData(
      userId: userId,
      name: name,
      email: email,
    );
  }

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    return await localDatasource.getNotifications();
  }

  @override
  Future<Either<Failure, void>> markAsRead(String notificationId) async {
    return await localDatasource.markAsRead(notificationId);
  }

  @override
  Future<Either<Failure, void>> markAllAsRead() async {
    return await localDatasource.markAllAsRead();
  }

  @override
  Future<Either<Failure, void>> deleteNotification(
    String notificationId,
  ) async {
    return await localDatasource.deleteNotification(notificationId);
  }

  @override
  Future<Either<Failure, void>> clearAllNotifications() async {
    return await localDatasource.clearAllNotifications();
  }

  @override
  Future<Either<Failure, int>> getNotificationCount() async {
    return await localDatasource.getNotificationCount();
  }

  @override
  Future<Either<Failure, int>> getUnreadCount() async {
    return await localDatasource.getUnreadCount();
  }

  @override
  Future<Either<Failure, void>> setNotificationPermission(bool enabled) async {
    return await remoteDatasource.setNotificationPermission(enabled);
  }

  @override
  Future<Either<Failure, bool>> getNotificationPermission() async {
    return await remoteDatasource.getNotificationPermission();
  }

  @override
  Future<Either<Failure, void>> sendLocalNotification({
    required NotificationContent content,
    NotificationCalendar? schedule,
    List<NotificationActionButton>? actionButtons,
    Map<String, NotificationLocalization>? localizations,
  }) async {
    try {
      final result = await AwesomeNotifications().createNotification(
        content: content,
        schedule: schedule,
        actionButtons: actionButtons,
        localizations: localizations,
      );

      if (result) return right(null);

      return left(
        NotificationFailure(
          message: "Failed to schedule local notification",
          error: result,
        ),
      );
    } catch (error) {
      return left(
        NotificationFailure(
          message: "Failed to schedule local notification",
          error: error,
        ),
      );
    }
  }
}
