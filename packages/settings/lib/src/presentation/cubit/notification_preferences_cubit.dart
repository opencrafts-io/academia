import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permissions/permissions.dart';

class NotificationPreferencesState {
  const NotificationPreferencesState({
    this.notifications,
    this.preciseAlarms,
    this.isLoading = false,
  });

  final PermissionStatus? notifications;
  final PermissionStatus? preciseAlarms;
  final bool isLoading;

  NotificationPreferencesState copyWith({
    PermissionStatus? notifications,
    PermissionStatus? preciseAlarms,
    bool? isLoading,
  }) {
    return NotificationPreferencesState(
      notifications: notifications ?? this.notifications,
      preciseAlarms: preciseAlarms ?? this.preciseAlarms,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class NotificationPreferencesCubit extends Cubit<NotificationPreferencesState> {
  NotificationPreferencesCubit(
    this._gateway,
    this._requestObserver, {
    this.supportsPreciseAlarms = true,
  }) : super(const NotificationPreferencesState());

  final PermissionGateway _gateway;
  final PermissionRequestObserver _requestObserver;
  final bool supportsPreciseAlarms;

  Future<void> refresh() async {
    emit(state.copyWith(isLoading: true));
    final notifications = await _gateway.check(
      PermissionCapability.notifications,
    );
    final preciseAlarms = supportsPreciseAlarms
        ? await _gateway.check(PermissionCapability.preciseAlarms)
        : null;
    emit(
      NotificationPreferencesState(
        notifications: notifications,
        preciseAlarms: preciseAlarms,
      ),
    );
  }

  Future<void> requestPreciseAlarms() async {
    if (!supportsPreciseAlarms) return;

    final status = await _gateway.request(PermissionCapability.preciseAlarms);
    _requestObserver.onPermissionRequested(
      PermissionCapability.preciseAlarms,
      status,
    );
    emit(state.copyWith(preciseAlarms: status, isLoading: false));
  }

  Future<void> openSystemSettings() => _gateway.openSystemSettings();
}
