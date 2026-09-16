import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_blocker/app_blocker.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// ---------------------------------------------------------------------------
// Mock platform
// ---------------------------------------------------------------------------

class MockAppBlockerPlatform extends AppBlockerPlatform
    with MockPlatformInterfaceMixin {
  // -- Capabilities --

  BlockerCapabilities capabilitiesResult = const BlockerCapabilities(
    canBlockApps: true,
    canCustomizeBlockScreen: true,
    canUseSystemShield: false,
    canSchedule: true,
    canGetInstalledApps: true,
    canShowActivityPicker: false,
  );

  @override
  Future<BlockerCapabilities> getCapabilities() async => capabilitiesResult;

  // -- Permissions --

  BlockerPermissionStatus permissionResult = BlockerPermissionStatus.granted;

  @override
  Future<BlockerPermissionStatus> checkPermission() async => permissionResult;

  @override
  Future<BlockerPermissionStatus> requestPermission() async => permissionResult;

  // -- App Discovery --

  List<AppInfo> appsResult = [];

  @override
  Future<List<AppInfo>> getApps() async => appsResult;

  // -- Blocking --

  List<String>? lastBlockedIdentifiers;
  List<String>? lastUnblockedIdentifiers;
  bool blockAllCalled = false;
  bool unblockAllCalled = false;

  @override
  Future<void> blockApps(List<String> appIdentifiers) async {
    lastBlockedIdentifiers = appIdentifiers;
  }

  @override
  Future<void> blockAll() async {
    blockAllCalled = true;
  }

  @override
  Future<void> unblockApps(List<String> appIdentifiers) async {
    lastUnblockedIdentifiers = appIdentifiers;
  }

  @override
  Future<void> unblockAll() async {
    unblockAllCalled = true;
  }

  List<String> blockedAppsResult = [];

  @override
  Future<List<String>> getBlockedApps() async => blockedAppsResult;

  BlockStatus appStatusResult = BlockStatus.unblocked;

  @override
  Future<BlockStatus> getAppStatus(String appIdentifier) async =>
      appStatusResult;

  // -- Events --

  final StreamController<BlockEvent> _eventController =
      StreamController<BlockEvent>.broadcast();

  @override
  Stream<BlockEvent> get onBlockEvent => _eventController.stream;

  void emitEvent(BlockEvent event) => _eventController.add(event);

  // -- Block Screen Config --

  BlockScreenConfig? lastBlockScreenConfig;
  BlockScreenConfig? getBlockScreenConfigResult;

  @override
  Future<void> setBlockScreenConfig(BlockScreenConfig config) async {
    lastBlockScreenConfig = config;
  }

  @override
  Future<BlockScreenConfig?> getBlockScreenConfig() async =>
      getBlockScreenConfigResult;

  // -- Scheduling --

  BlockSchedule? lastAddedSchedule;
  BlockSchedule? lastUpdatedSchedule;
  String? lastRemovedScheduleId;
  String? lastEnabledScheduleId;
  String? lastDisabledScheduleId;
  List<BlockSchedule> schedulesResult = [];

  @override
  Future<void> addSchedule(BlockSchedule schedule) async {
    lastAddedSchedule = schedule;
  }

  @override
  Future<void> updateSchedule(BlockSchedule schedule) async {
    lastUpdatedSchedule = schedule;
  }

  @override
  Future<void> removeSchedule(String scheduleId) async {
    lastRemovedScheduleId = scheduleId;
  }

  @override
  Future<List<BlockSchedule>> getSchedules() async => schedulesResult;

  @override
  Future<void> enableSchedule(String scheduleId) async {
    lastEnabledScheduleId = scheduleId;
  }

  @override
  Future<void> disableSchedule(String scheduleId) async {
    lastDisabledScheduleId = scheduleId;
  }

  // -- Profiles --

  BlockProfile? lastCreatedProfile;
  BlockProfile? lastUpdatedProfile;
  String? lastDeletedProfileId;
  String? lastActivatedProfileId;
  String? lastDeactivatedProfileId;
  List<BlockProfile> profilesResult = [];
  BlockProfile? activeProfileResult;

  @override
  Future<void> createProfile(BlockProfile profile) async {
    lastCreatedProfile = profile;
  }

  @override
  Future<void> updateProfile(BlockProfile profile) async {
    lastUpdatedProfile = profile;
  }

  @override
  Future<void> deleteProfile(String profileId) async {
    lastDeletedProfileId = profileId;
  }

  @override
  Future<List<BlockProfile>> getProfiles() async => profilesResult;

  @override
  Future<void> activateProfile(String profileId) async {
    lastActivatedProfileId = profileId;
  }

  @override
  Future<void> deactivateProfile(String profileId) async {
    lastDeactivatedProfileId = profileId;
  }

  @override
  Future<BlockProfile?> getActiveProfile() async => activeProfileResult;
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockAppBlockerPlatform mockPlatform;
  late AppBlocker blocker;

  setUp(() {
    mockPlatform = MockAppBlockerPlatform();
    AppBlockerPlatform.instance = mockPlatform;
    blocker = AppBlocker.instance;
  });

  // == Capabilities ==

  group('getCapabilities', () {
    test('returns correct BlockerCapabilities', () async {
      final caps = await blocker.getCapabilities();

      expect(caps.canBlockApps, isTrue);
      expect(caps.canCustomizeBlockScreen, isTrue);
      expect(caps.canUseSystemShield, isFalse);
      expect(caps.canSchedule, isTrue);
      expect(caps.canGetInstalledApps, isTrue);
      expect(caps.canShowActivityPicker, isFalse);
    });
  });

  // == Permissions ==

  group('permissions', () {
    test('checkPermission returns granted', () async {
      mockPlatform.permissionResult = BlockerPermissionStatus.granted;
      expect(await blocker.checkPermission(), BlockerPermissionStatus.granted);
    });

    test('checkPermission returns denied', () async {
      mockPlatform.permissionResult = BlockerPermissionStatus.denied;
      expect(await blocker.checkPermission(), BlockerPermissionStatus.denied);
    });

    test('checkPermission returns restricted', () async {
      mockPlatform.permissionResult = BlockerPermissionStatus.restricted;
      expect(
        await blocker.checkPermission(),
        BlockerPermissionStatus.restricted,
      );
    });

    test('requestPermission returns correct status', () async {
      mockPlatform.permissionResult = BlockerPermissionStatus.granted;
      expect(
        await blocker.requestPermission(),
        BlockerPermissionStatus.granted,
      );
    });
  });

  // == App Discovery ==

  group('getApps', () {
    test('returns list of AppInfo', () async {
      mockPlatform.appsResult = [
        const AppInfo(packageName: 'com.example.app1', appName: 'App One'),
        const AppInfo(
          packageName: 'com.example.app2',
          appName: 'App Two',
          isSystemApp: true,
        ),
      ];

      final apps = await blocker.getApps();

      expect(apps, hasLength(2));
      expect(apps[0].packageName, 'com.example.app1');
      expect(apps[0].appName, 'App One');
      expect(apps[0].isSystemApp, isFalse);
      expect(apps[1].packageName, 'com.example.app2');
      expect(apps[1].isSystemApp, isTrue);
    });

    test('returns empty list when no apps', () async {
      mockPlatform.appsResult = [];
      final apps = await blocker.getApps();
      expect(apps, isEmpty);
    });
  });

  // == Blocking ==

  group('blocking', () {
    test('blockApps completes without error', () async {
      final ids = ['com.example.app1', 'com.example.app2'];
      await blocker.blockApps(ids);
      expect(mockPlatform.lastBlockedIdentifiers, ids);
    });

    test('blockAll completes without error', () async {
      await blocker.blockAll();
      expect(mockPlatform.blockAllCalled, isTrue);
    });

    test('unblockApps completes without error', () async {
      final ids = ['com.example.app1'];
      await blocker.unblockApps(ids);
      expect(mockPlatform.lastUnblockedIdentifiers, ids);
    });

    test('unblockAll completes without error', () async {
      await blocker.unblockAll();
      expect(mockPlatform.unblockAllCalled, isTrue);
    });
  });

  // == Blocked Apps ==

  group('getBlockedApps', () {
    test('returns correct list', () async {
      mockPlatform.blockedAppsResult = ['com.example.app1', 'com.example.app2'];
      final blocked = await blocker.getBlockedApps();

      expect(blocked, hasLength(2));
      expect(blocked, contains('com.example.app1'));
      expect(blocked, contains('com.example.app2'));
    });

    test('returns empty list when nothing blocked', () async {
      mockPlatform.blockedAppsResult = [];
      expect(await blocker.getBlockedApps(), isEmpty);
    });
  });

  // == App Status ==

  group('getAppStatus', () {
    test('returns blocked status', () async {
      mockPlatform.appStatusResult = BlockStatus.blocked;
      expect(
        await blocker.getAppStatus('com.example.app1'),
        BlockStatus.blocked,
      );
    });

    test('returns unblocked status', () async {
      mockPlatform.appStatusResult = BlockStatus.unblocked;
      expect(
        await blocker.getAppStatus('com.example.app1'),
        BlockStatus.unblocked,
      );
    });

    test('returns scheduled status', () async {
      mockPlatform.appStatusResult = BlockStatus.scheduled;
      expect(
        await blocker.getAppStatus('com.example.app1'),
        BlockStatus.scheduled,
      );
    });
  });

  // == Events ==

  group('onBlockEvent', () {
    test('delivers events from the platform stream', () async {
      final event = BlockEvent(
        type: BlockEventType.blocked,
        timestamp: DateTime(2026, 3, 22),
        packageName: 'com.example.app1',
      );

      final future = blocker.onBlockEvent.first;
      mockPlatform.emitEvent(event);

      final received = await future;
      expect(received.type, BlockEventType.blocked);
      expect(received.packageName, 'com.example.app1');
    });

    test('delivers multiple events in order', () async {
      final events = <BlockEvent>[];
      final sub = blocker.onBlockEvent.listen(events.add);

      mockPlatform.emitEvent(
        BlockEvent(
          type: BlockEventType.blocked,
          timestamp: DateTime(2026, 1, 1),
          packageName: 'app1',
        ),
      );
      mockPlatform.emitEvent(
        BlockEvent(
          type: BlockEventType.unblocked,
          timestamp: DateTime(2026, 1, 2),
          packageName: 'app1',
        ),
      );

      // Let microtasks complete.
      await Future<void>.delayed(Duration.zero);

      expect(events, hasLength(2));
      expect(events[0].type, BlockEventType.blocked);
      expect(events[1].type, BlockEventType.unblocked);

      await sub.cancel();
    });
  });

  // == Block Screen Config ==

  group('setBlockScreenConfig', () {
    test('completes and passes config to platform', () async {
      const config = BlockScreenConfig(
        title: 'Blocked',
        subtitle: 'Focus time',
        message: 'This app is blocked.',
      );

      await blocker.setBlockScreenConfig(config);
      expect(mockPlatform.lastBlockScreenConfig?.title, 'Blocked');
      expect(mockPlatform.lastBlockScreenConfig?.subtitle, 'Focus time');
      expect(
        mockPlatform.lastBlockScreenConfig?.message,
        'This app is blocked.',
      );
    });
  });

  group('getBlockScreenConfig', () {
    test('returns config when set', () async {
      const config = BlockScreenConfig(
        title: 'Test Title',
        subtitle: 'Test Subtitle',
        message: 'Test Message',
      );
      mockPlatform.getBlockScreenConfigResult = config;

      final result = await blocker.getBlockScreenConfig();

      expect(result, isNotNull);
      expect(result!.title, 'Test Title');
      expect(result.subtitle, 'Test Subtitle');
      expect(result.message, 'Test Message');
    });

    test('returns null when no config', () async {
      mockPlatform.getBlockScreenConfigResult = null;
      final result = await blocker.getBlockScreenConfig();
      expect(result, isNull);
    });
  });

  // == Scheduling ==

  group('schedule CRUD', () {
    final schedule = BlockSchedule(
      id: 'sched-1',
      name: 'Work Hours',
      appIdentifiers: ['com.example.app1'],
      weekdays: [1, 2, 3, 4, 5],
      startTime: const TimeOfDay(hour: 9, minute: 0),
      endTime: const TimeOfDay(hour: 17, minute: 0),
    );

    test('addSchedule completes', () async {
      await blocker.addSchedule(schedule);
      expect(mockPlatform.lastAddedSchedule?.id, 'sched-1');
    });

    test('updateSchedule completes', () async {
      final updated = schedule.copyWith(name: 'Updated');
      await blocker.updateSchedule(updated);
      expect(mockPlatform.lastUpdatedSchedule?.name, 'Updated');
    });

    test('removeSchedule completes', () async {
      await blocker.removeSchedule('sched-1');
      expect(mockPlatform.lastRemovedScheduleId, 'sched-1');
    });

    test('getSchedules returns list', () async {
      mockPlatform.schedulesResult = [schedule];
      final result = await blocker.getSchedules();

      expect(result, hasLength(1));
      expect(result.first.id, 'sched-1');
      expect(result.first.name, 'Work Hours');
    });

    test('enableSchedule completes', () async {
      await blocker.enableSchedule('sched-1');
      expect(mockPlatform.lastEnabledScheduleId, 'sched-1');
    });

    test('disableSchedule completes', () async {
      await blocker.disableSchedule('sched-1');
      expect(mockPlatform.lastDisabledScheduleId, 'sched-1');
    });
  });

  // == Profiles ==

  group('profile CRUD', () {
    const profile = BlockProfile(
      id: 'prof-1',
      name: 'Work Mode',
      appIdentifiers: ['com.example.app1', 'com.example.app2'],
    );

    test('createProfile completes', () async {
      await blocker.createProfile(profile);
      expect(mockPlatform.lastCreatedProfile?.id, 'prof-1');
      expect(mockPlatform.lastCreatedProfile?.name, 'Work Mode');
    });

    test('updateProfile completes', () async {
      final updated = profile.copyWith(name: 'Sleep Mode');
      await blocker.updateProfile(updated);
      expect(mockPlatform.lastUpdatedProfile?.name, 'Sleep Mode');
    });

    test('deleteProfile completes', () async {
      await blocker.deleteProfile('prof-1');
      expect(mockPlatform.lastDeletedProfileId, 'prof-1');
    });

    test('getProfiles returns list', () async {
      mockPlatform.profilesResult = [profile];
      final result = await blocker.getProfiles();

      expect(result, hasLength(1));
      expect(result.first.name, 'Work Mode');
    });

    test('activateProfile completes', () async {
      await blocker.activateProfile('prof-1');
      expect(mockPlatform.lastActivatedProfileId, 'prof-1');
    });

    test('deactivateProfile completes', () async {
      await blocker.deactivateProfile('prof-1');
      expect(mockPlatform.lastDeactivatedProfileId, 'prof-1');
    });

    test('getActiveProfile returns profile when active', () async {
      mockPlatform.activeProfileResult = profile.copyWith(isActive: true);
      final active = await blocker.getActiveProfile();

      expect(active, isNotNull);
      expect(active!.id, 'prof-1');
      expect(active.isActive, isTrue);
    });

    test('getActiveProfile returns null when none active', () async {
      mockPlatform.activeProfileResult = null;
      final active = await blocker.getActiveProfile();
      expect(active, isNull);
    });
  });
}
