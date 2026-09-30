import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:permissions/permissions.dart';

class _FakePermissionGateway implements PermissionGateway {
  _FakePermissionGateway({
    required this.checkResults,
    required this.requestResult,
  });

  final Map<PermissionCapability, PermissionStatus> checkResults;
  final PermissionStatus requestResult;
  bool openedSystemSettings = false;

  @override
  Future<PermissionStatus> check(PermissionCapability capability) async {
    return checkResults[capability] ?? PermissionStatus.denied;
  }

  @override
  Future<void> openSystemSettings() async {
    openedSystemSettings = true;
  }

  @override
  Future<PermissionStatus> request(PermissionCapability capability) async {
    return requestResult;
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

void main() {
  test('registers capability-based permission dependencies', () {
    final getIt = GetIt.asNewInstance();

    configurePermissionsDependencies(getIt);

    expect(getIt<PermissionGateway>(), isA<PermissionGateway>());
    expect(getIt<PermissionCubit>(), isA<PermissionCubit>());
  });

  test('prioritizes a permanently denied capability when checking all', () async {
    final gateway = _FakePermissionGateway(
      checkResults: {
        PermissionCapability.notifications: PermissionStatus.granted,
        PermissionCapability.preciseAlarms: PermissionStatus.permanentlyDenied,
      },
      requestResult: PermissionStatus.granted,
    );
    final cubit = PermissionCubit(
      gateway,
      _RecordingPermissionRequestObserver(),
    );

    await cubit.checkAll([
      PermissionCapability.notifications,
      PermissionCapability.preciseAlarms,
    ]);

    expect(cubit.state, isA<PermissionPermanentlyDenied>());
    await cubit.close();
  });

  test('records the capability and status when a request completes', () async {
    final observer = _RecordingPermissionRequestObserver();
    final cubit = PermissionCubit(
      _FakePermissionGateway(
        checkResults: const {},
        requestResult: PermissionStatus.granted,
      ),
      observer,
    );

    await cubit.request(PermissionCapability.notifications);

    expect(cubit.state, isA<PermissionGranted>());
    expect(observer.capability, PermissionCapability.notifications);
    expect(observer.status, PermissionStatus.granted);
    await cubit.close();
  });

  test('emits the checked status for one product capability', () async {
    final cubit = PermissionCubit(
      _FakePermissionGateway(
        checkResults: {
          PermissionCapability.notifications: PermissionStatus.denied,
        },
        requestResult: PermissionStatus.granted,
      ),
      _RecordingPermissionRequestObserver(),
    );

    await cubit.check(PermissionCapability.notifications);

    expect(cubit.state, isA<PermissionDenied>());
    await cubit.close();
  });

  test('delegates the system-settings deep link to the gateway', () async {
    final gateway = _FakePermissionGateway(
      checkResults: const {},
      requestResult: PermissionStatus.granted,
    );
    final cubit = PermissionCubit(
      gateway,
      _RecordingPermissionRequestObserver(),
    );

    await cubit.openSystemSettings();

    expect(gateway.openedSystemSettings, isTrue);
    await cubit.close();
  });

  test('exposes the notification prompt through its typed route', () {
    const route = NotificationPermissionRoute();

    expect(route.location, '/notification-allow');
    expect(routes, hasLength(1));
  });

  testWidgets('keeps the branded notification illustration', (tester) async {
    final cubit = PermissionCubit(
      _FakePermissionGateway(
        checkResults: const {},
        requestResult: PermissionStatus.granted,
      ),
      _RecordingPermissionRequestObserver(),
    );
    addTearDown(cubit.close);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: cubit,
          child: const NotificationPermissionScreen(),
        ),
      ),
    );

    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);
    final image = tester.widget<Image>(imageFinder);

    expect(
      (image.image as AssetImage).assetName,
      'assets/icons/notification_bell.png',
    );
  });
}
