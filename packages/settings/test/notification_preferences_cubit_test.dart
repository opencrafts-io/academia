import 'package:flutter_test/flutter_test.dart';
import 'package:permissions/permissions.dart';
import 'package:settings/settings.dart';

void main() {
  test('keeps notification and precise-alarm status independent', () async {
    final cubit = NotificationPreferencesCubit(
      _FakePermissionGateway(
        notificationStatus: PermissionStatus.granted,
        preciseAlarmStatus: PermissionStatus.denied,
      ),
      _RecordingPermissionRequestObserver(),
    );

    await cubit.refresh();

    expect(cubit.state.notifications, PermissionStatus.granted);
    expect(cubit.state.preciseAlarms, PermissionStatus.denied);
    await cubit.close();
  });

  test('records an explicit precise-alarm request', () async {
    final observer = _RecordingPermissionRequestObserver();
    final cubit = NotificationPreferencesCubit(
      _FakePermissionGateway(
        notificationStatus: PermissionStatus.granted,
        preciseAlarmStatus: PermissionStatus.denied,
        requestedPreciseAlarmStatus: PermissionStatus.granted,
      ),
      observer,
    );

    await cubit.requestPreciseAlarms();

    expect(cubit.state.preciseAlarms, PermissionStatus.granted);
    expect(observer.capability, PermissionCapability.preciseAlarms);
    expect(observer.status, PermissionStatus.granted);
    await cubit.close();
  });

  test('skips precise-alarm checks where alarms are unsupported', () async {
    final gateway = _FakePermissionGateway(
      notificationStatus: PermissionStatus.granted,
      preciseAlarmStatus: PermissionStatus.denied,
    );
    final cubit = NotificationPreferencesCubit(
      gateway,
      _RecordingPermissionRequestObserver(),
      supportsPreciseAlarms: false,
    );

    await cubit.refresh();
    await cubit.requestPreciseAlarms();

    expect(cubit.state.notifications, PermissionStatus.granted);
    expect(cubit.state.preciseAlarms, isNull);
    expect(gateway.preciseAlarmChecks, 0);
    expect(gateway.preciseAlarmRequests, 0);
    await cubit.close();
  });
}

class _FakePermissionGateway implements PermissionGateway {
  _FakePermissionGateway({
    required this.notificationStatus,
    required this.preciseAlarmStatus,
    this.requestedPreciseAlarmStatus,
  });

  final PermissionStatus notificationStatus;
  final PermissionStatus preciseAlarmStatus;
  final PermissionStatus? requestedPreciseAlarmStatus;
  int preciseAlarmChecks = 0;
  int preciseAlarmRequests = 0;

  @override
  Future<PermissionStatus> check(PermissionCapability capability) async {
    return switch (capability) {
      PermissionCapability.notifications => notificationStatus,
      PermissionCapability.preciseAlarms => () {
        preciseAlarmChecks++;
        return preciseAlarmStatus;
      }(),
      _ => PermissionStatus.denied,
    };
  }

  @override
  Future<void> openSystemSettings() async {}

  @override
  Future<PermissionStatus> request(PermissionCapability capability) async {
    return switch (capability) {
      PermissionCapability.preciseAlarms => () {
        preciseAlarmRequests++;
        return requestedPreciseAlarmStatus ?? preciseAlarmStatus;
      }(),
      _ => PermissionStatus.denied,
    };
  }
}

class _RecordingPermissionRequestObserver implements PermissionRequestObserver {
  PermissionCapability? capability;
  PermissionStatus? status;

  @override
  void onPermissionRequested(
    PermissionCapability requestedCapability,
    PermissionStatus requestedStatus,
  ) {
    capability = requestedCapability;
    status = requestedStatus;
  }
}
