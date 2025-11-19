import 'package:academia/core/core.dart';
import 'package:academia/features/notifications/notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final InitializeOneSignalUsecase initializeOneSignalUsecase;
  final InitializeLocalNotificationsUsecase initializeLocalNotificationsUsecase;
  final GetNotificationsUsecase getNotificationsUsecase;
  final MarkNotificationAsReadUsecase markNotificationAsReadUsecase;
  final MarkAllNotificationsAsReadUsecase markAllNotificationsAsReadUsecase;
  final DeleteNotificationUsecase deleteNotificationUsecase;
  final ClearAllNotificationsUsecase clearAllNotificationsUsecase;
  final GetNotificationCountUsecase getNotificationCountUsecase;
  final GetUnreadCountUsecase getUnreadCountUsecase;
  final SetNotificationPermissionUsecase setNotificationPermissionUsecase;
  final GetNotificationPermissionUsecase getNotificationPermissionUsecase;
  final SendLocalNotificationUsecase sendLocalNotificationUsecase;
  final SetUserDataUsecase setUserDataUsecase;

  final Logger _logger = Logger();

  NotificationBloc({
    required this.initializeLocalNotificationsUsecase,
    required this.initializeOneSignalUsecase,
    required this.getNotificationsUsecase,
    required this.markNotificationAsReadUsecase,
    required this.markAllNotificationsAsReadUsecase,
    required this.deleteNotificationUsecase,
    required this.clearAllNotificationsUsecase,
    required this.getNotificationCountUsecase,
    required this.getUnreadCountUsecase,
    required this.setNotificationPermissionUsecase,
    required this.getNotificationPermissionUsecase,
    required this.sendLocalNotificationUsecase,
    required this.setUserDataUsecase,
  }) : super(NotificationInitialState()) {
    on<InitializeOneSignalEvent>(_onInitializeOneSignal);
    on<InitializeLocalNotificationEvent>(_onInitializeLocalNotificationEvent);
    on<LoadNotificationsEvent>(_onLoadNotifications);
    on<MarkNotificationAsReadEvent>(_onMarkNotificationAsRead);
    on<MarkAllNotificationsAsReadEvent>(_onMarkAllNotificationsAsRead);
    on<DeleteNotificationEvent>(_onDeleteNotification);
    on<ClearAllNotificationsEvent>(_onClearAllNotifications);
    on<GetNotificationCountEvent>(_onGetNotificationCount);
    on<GetUnreadCountEvent>(_onGetUnreadCount);
    on<SetNotificationPermissionEvent>(_onSetNotificationPermission);
    on<GetNotificationPermissionEvent>(_onGetNotificationPermission);
    on<SendLocalNotificationEvent>(_onSendLocalNotification);
    on<SetUserDataEvent>(_onSetUserData);
  }

  Future<void> _onInitializeLocalNotificationEvent(
    InitializeLocalNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoadingState());

    final result = await initializeLocalNotificationsUsecase(event.channels);

    result.fold(
      (failure) {
        _logger.e('Failed to initialize local notifications', error: failure.error);
        emit(NotificationErrorState(message: failure.message));
      },
      (_) {
        emit(NotificationInitializedState());
      },
    );
  }

  Future<void> _onInitializeOneSignal(
    InitializeOneSignalEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoadingState());

    final result = await initializeOneSignalUsecase(event.appId);

    result.fold(
      (failure) {
        _logger.e('Failed to initialize OneSignal', error: failure.error);
        emit(NotificationErrorState(message: failure.message));
      },
      (_) {
        emit(NotificationInitializedState());
      },
    );
  }

  Future<void> _onLoadNotifications(
    LoadNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoadingState());

    final result = await getNotificationsUsecase(NoParams());

    result.fold(
      (failure) {
        _logger.e('Failed to load notifications', error: failure.error);
        emit(NotificationErrorState(message: failure.message));
      },
      (notifications) {
        emit(NotificationsLoadedState(notifications: notifications));
      },
    );
  }

  Future<void> _onMarkNotificationAsRead(
    MarkNotificationAsReadEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await markNotificationAsReadUsecase(event.notificationId);

    result.fold(
      (failure) {
        _logger.e('Failed to mark notification as read', error: failure.error);
        emit(NotificationErrorState(message: failure.message));
      },
      (_) {
        add(LoadNotificationsEvent());
      },
    );
  }

  Future<void> _onMarkAllNotificationsAsRead(
    MarkAllNotificationsAsReadEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await markAllNotificationsAsReadUsecase(NoParams());

    result.fold(
      (failure) {
        _logger.e(
          'Failed to mark all notifications as read',
          error: failure.error,
        );
        emit(NotificationErrorState(message: failure.message));
      },
      (_) {
        add(LoadNotificationsEvent());
      },
    );
  }

  Future<void> _onDeleteNotification(
    DeleteNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await deleteNotificationUsecase(event.notificationId);

    result.fold(
      (failure) {
        _logger.e('Failed to delete notification', error: failure.error);
        emit(NotificationErrorState(message: failure.message));
      },
      (_) {
        add(LoadNotificationsEvent());
      },
    );
  }

  Future<void> _onClearAllNotifications(
    ClearAllNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await clearAllNotificationsUsecase(NoParams());

    result.fold(
      (failure) {
        _logger.e('Failed to clear all notifications', error: failure.error);
        emit(NotificationErrorState(message: failure.message));
      },
      (_) {
        add(LoadNotificationsEvent());
      },
    );
  }

  Future<void> _onGetNotificationCount(
    GetNotificationCountEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await getNotificationCountUsecase(NoParams());

    result.fold(
      (failure) {
        _logger.e('Failed to get notification count', error: failure.error);
        emit(NotificationErrorState(message: failure.message));
      },
      (count) {
        emit(NotificationCountLoadedState(count: count));
      },
    );
  }

  Future<void> _onGetUnreadCount(
    GetUnreadCountEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await getUnreadCountUsecase(NoParams());

    result.fold(
      (failure) {
        _logger.e('Failed to get unread count', error: failure.error);
        emit(NotificationErrorState(message: failure.message));
      },
      (count) {
        emit(UnreadCountLoadedState(count: count));
      },
    );
  }

  Future<void> _onSetNotificationPermission(
    SetNotificationPermissionEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await setNotificationPermissionUsecase(event.enabled);

    result.fold(
      (failure) {
        _logger.e(
          'Failed to set notification permission',
          error: failure.error,
        );
        emit(NotificationErrorState(message: failure.message));
      },
      (_) {
        emit(NotificationPermissionSetState(enabled: event.enabled));
      },
    );
  }

  Future<void> _onGetNotificationPermission(
    GetNotificationPermissionEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await getNotificationPermissionUsecase(NoParams());

    result.fold(
      (failure) {
        _logger.e(
          'Failed to get notification permission',
          error: failure.error,
        );
        emit(NotificationErrorState(message: failure.message));
      },
      (enabled) {
        emit(NotificationPermissionLoadedState(enabled: enabled));
      },
    );
  }

  Future<void> _onSendLocalNotification(
    SendLocalNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final params = SendLocalNotificationParams(
      actionButtons: event.actionButtons,
      localizations: event.localizations,
      content: event.content,
      schedule: event.schedule,
    );

    final result = await sendLocalNotificationUsecase(params);

    result.fold(
      (failure) {
        _logger.e('Failed to send local notification', error: failure.error);
        emit(NotificationErrorState(message: failure.message));
      },
      (_) {
        emit(LocalNotificationSentState());
      },
    );
  }

  Future<void> _onSetUserData(
    SetUserDataEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final params = SetUserDataParams(
      userId: event.userId,
      name: event.name,
      email: event.email,
    );

    final result = await setUserDataUsecase(params);

    result.fold(
      (failure) {
        _logger.e('Failed to set user data', error: failure.error);
        emit(NotificationErrorState(message: failure.message));
      },
      (_) {
        emit(
          UserDataSetState(
            userId: event.userId,
            name: event.name,
            email: event.email,
          ),
        );
      },
    );
  }
}
