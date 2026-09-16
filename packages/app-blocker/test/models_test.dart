import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_blocker/app_blocker.dart';

void main() {
  // =========================================================================
  // AppInfo
  // =========================================================================

  group('AppInfo', () {
    test('fromMap creates instance with all fields', () {
      final icon = Uint8List.fromList([0, 1, 2, 3]);
      final map = <String, dynamic>{
        'packageName': 'com.example.app',
        'appName': 'Example',
        'icon': icon,
        'isSystemApp': true,
      };

      final info = AppInfo.fromMap(map);

      expect(info.packageName, 'com.example.app');
      expect(info.appName, 'Example');
      expect(info.icon, icon);
      expect(info.isSystemApp, isTrue);
    });

    test('fromMap defaults isSystemApp to false', () {
      final map = <String, dynamic>{
        'packageName': 'com.example.app',
        'appName': 'Example',
      };

      final info = AppInfo.fromMap(map);
      expect(info.isSystemApp, isFalse);
    });

    test('fromMap handles null icon', () {
      final map = <String, dynamic>{
        'packageName': 'com.example.app',
        'appName': 'Example',
        'icon': null,
        'isSystemApp': false,
      };

      final info = AppInfo.fromMap(map);
      expect(info.icon, isNull);
    });

    test('toMap produces correct map', () {
      final icon = Uint8List.fromList([10, 20]);
      final info = AppInfo(
        packageName: 'com.example.app',
        appName: 'Example',
        icon: icon,
        isSystemApp: true,
      );

      final map = info.toMap();

      expect(map['packageName'], 'com.example.app');
      expect(map['appName'], 'Example');
      expect(map['icon'], icon);
      expect(map['isSystemApp'], isTrue);
    });

    test('fromMap -> toMap roundtrip', () {
      final original = <String, dynamic>{
        'packageName': 'com.test',
        'appName': 'Test App',
        'icon': null,
        'isSystemApp': false,
      };

      final roundtripped = AppInfo.fromMap(original).toMap();

      expect(roundtripped['packageName'], original['packageName']);
      expect(roundtripped['appName'], original['appName']);
      expect(roundtripped['isSystemApp'], original['isSystemApp']);
    });

    test('equality is based on packageName', () {
      const a = AppInfo(packageName: 'com.a', appName: 'A');
      const b = AppInfo(packageName: 'com.a', appName: 'B');
      const c = AppInfo(packageName: 'com.c', appName: 'A');

      expect(a, equals(b));
      expect(a, isNot(equals(c)));
    });

    test('hashCode is based on packageName', () {
      const a = AppInfo(packageName: 'com.a', appName: 'A');
      const b = AppInfo(packageName: 'com.a', appName: 'B');

      expect(a.hashCode, equals(b.hashCode));
    });

    test('toString contains package and app name', () {
      const info = AppInfo(packageName: 'com.x', appName: 'X');
      expect(info.toString(), contains('com.x'));
      expect(info.toString(), contains('X'));
    });
  });

  // =========================================================================
  // BlockEvent
  // =========================================================================

  group('BlockEvent', () {
    test('fromMap creates instance with all fields', () {
      final map = <String, dynamic>{
        'type': 'blocked',
        'timestamp': 1711100000000,
        'packageName': 'com.example.app',
        'scheduleId': 'sched-1',
        'profileId': 'prof-1',
      };

      final event = BlockEvent.fromMap(map);

      expect(event.type, BlockEventType.blocked);
      expect(
        event.timestamp,
        DateTime.fromMillisecondsSinceEpoch(1711100000000),
      );
      expect(event.packageName, 'com.example.app');
      expect(event.scheduleId, 'sched-1');
      expect(event.profileId, 'prof-1');
    });

    test('fromMap with null optional fields', () {
      final map = <String, dynamic>{
        'type': 'unblocked',
        'timestamp': 1711100000000,
        'packageName': null,
        'scheduleId': null,
      };

      final event = BlockEvent.fromMap(map);

      expect(event.type, BlockEventType.unblocked);
      expect(event.packageName, isNull);
      expect(event.scheduleId, isNull);
    });

    test('fromMap parses all event types', () {
      for (final eventType in BlockEventType.values) {
        final map = <String, dynamic>{
          'type': eventType.name,
          'timestamp': 1711100000000,
        };
        final event = BlockEvent.fromMap(map);
        expect(event.type, eventType);
      }
    });

    test('toString contains type and packageName', () {
      final event = BlockEvent(
        type: BlockEventType.attemptedAccess,
        timestamp: DateTime(2026, 3, 22),
        packageName: 'com.test',
      );
      final str = event.toString();
      expect(str, contains('attemptedAccess'));
      expect(str, contains('com.test'));
    });
  });

  // =========================================================================
  // BlockerCapabilities
  // =========================================================================

  group('BlockerCapabilities', () {
    test('fromMap creates instance with all true', () {
      final map = <String, dynamic>{
        'canBlockApps': true,
        'canCustomizeBlockScreen': true,
        'canUseSystemShield': true,
        'canSchedule': true,
        'canGetInstalledApps': true,
        'canShowActivityPicker': true,
      };

      final caps = BlockerCapabilities.fromMap(map);

      expect(caps.canBlockApps, isTrue);
      expect(caps.canCustomizeBlockScreen, isTrue);
      expect(caps.canUseSystemShield, isTrue);
      expect(caps.canSchedule, isTrue);
      expect(caps.canGetInstalledApps, isTrue);
      expect(caps.canShowActivityPicker, isTrue);
    });

    test('fromMap defaults missing booleans to false', () {
      final map = <String, dynamic>{};

      final caps = BlockerCapabilities.fromMap(map);

      expect(caps.canBlockApps, isFalse);
      expect(caps.canCustomizeBlockScreen, isFalse);
      expect(caps.canUseSystemShield, isFalse);
      expect(caps.canSchedule, isFalse);
      expect(caps.canGetInstalledApps, isFalse);
      expect(caps.canShowActivityPicker, isFalse);
    });

    test('toString contains key fields', () {
      const caps = BlockerCapabilities(
        canBlockApps: true,
        canCustomizeBlockScreen: false,
        canUseSystemShield: true,
        canSchedule: false,
        canGetInstalledApps: true,
        canShowActivityPicker: false,
      );
      final str = caps.toString();
      expect(str, contains('canBlockApps: true'));
      expect(str, contains('canCustomizeBlockScreen: false'));
    });
  });

  // =========================================================================
  // BlockSchedule
  // =========================================================================

  group('BlockSchedule', () {
    test('fromMap creates correct instance', () {
      final map = <String, dynamic>{
        'id': 'sched-1',
        'name': 'Work',
        'appIdentifiers': ['com.a', 'com.b'],
        'weekdays': [1, 2, 3, 4, 5],
        'startHour': 9,
        'startMinute': 30,
        'endHour': 17,
        'endMinute': 0,
        'enabled': true,
      };

      final schedule = BlockSchedule.fromMap(map);

      expect(schedule.id, 'sched-1');
      expect(schedule.name, 'Work');
      expect(schedule.appIdentifiers, ['com.a', 'com.b']);
      expect(schedule.weekdays, [1, 2, 3, 4, 5]);
      expect(schedule.startTime, const TimeOfDay(hour: 9, minute: 30));
      expect(schedule.endTime, const TimeOfDay(hour: 17, minute: 0));
      expect(schedule.enabled, isTrue);
    });

    test('fromMap defaults enabled to true', () {
      final map = <String, dynamic>{
        'id': 's1',
        'name': 'Test',
        'appIdentifiers': <String>[],
        'weekdays': <int>[1],
        'startHour': 0,
        'startMinute': 0,
        'endHour': 0,
        'endMinute': 0,
      };

      final schedule = BlockSchedule.fromMap(map);
      expect(schedule.enabled, isTrue);
    });

    test('toMap produces correct keys', () {
      final schedule = BlockSchedule(
        id: 's1',
        name: 'Test',
        appIdentifiers: ['com.a'],
        weekdays: [6, 7],
        startTime: const TimeOfDay(hour: 22, minute: 15),
        endTime: const TimeOfDay(hour: 6, minute: 45),
        enabled: false,
      );

      final map = schedule.toMap();

      expect(map['id'], 's1');
      expect(map['name'], 'Test');
      expect(map['appIdentifiers'], ['com.a']);
      expect(map['weekdays'], [6, 7]);
      expect(map['startHour'], 22);
      expect(map['startMinute'], 15);
      expect(map['endHour'], 6);
      expect(map['endMinute'], 45);
      expect(map['enabled'], isFalse);
    });

    test('fromMap -> toMap roundtrip', () {
      final original = <String, dynamic>{
        'id': 'rt-1',
        'name': 'Roundtrip',
        'appIdentifiers': ['com.x'],
        'weekdays': [1, 3, 5],
        'startHour': 8,
        'startMinute': 0,
        'endHour': 12,
        'endMinute': 30,
        'enabled': true,
      };

      final roundtripped = BlockSchedule.fromMap(original).toMap();

      expect(roundtripped['id'], original['id']);
      expect(roundtripped['name'], original['name']);
      expect(roundtripped['appIdentifiers'], original['appIdentifiers']);
      expect(roundtripped['weekdays'], original['weekdays']);
      expect(roundtripped['startHour'], original['startHour']);
      expect(roundtripped['startMinute'], original['startMinute']);
      expect(roundtripped['endHour'], original['endHour']);
      expect(roundtripped['endMinute'], original['endMinute']);
      expect(roundtripped['enabled'], original['enabled']);
    });

    test('equality is based on id', () {
      final a = BlockSchedule(
        id: 's1',
        name: 'A',
        appIdentifiers: [],
        weekdays: [1],
        startTime: const TimeOfDay(hour: 0, minute: 0),
        endTime: const TimeOfDay(hour: 0, minute: 0),
      );
      final b = BlockSchedule(
        id: 's1',
        name: 'B',
        appIdentifiers: ['com.x'],
        weekdays: [1],
        startTime: const TimeOfDay(hour: 1, minute: 0),
        endTime: const TimeOfDay(hour: 2, minute: 0),
      );
      final c = BlockSchedule(
        id: 's2',
        name: 'A',
        appIdentifiers: [],
        weekdays: [1],
        startTime: const TimeOfDay(hour: 0, minute: 0),
        endTime: const TimeOfDay(hour: 0, minute: 0),
      );

      expect(a, equals(b));
      expect(a, isNot(equals(c)));
    });

    test('hashCode is based on id', () {
      final a = BlockSchedule(
        id: 's1',
        name: 'A',
        appIdentifiers: [],
        weekdays: [1],
        startTime: const TimeOfDay(hour: 0, minute: 0),
        endTime: const TimeOfDay(hour: 0, minute: 0),
      );
      final b = BlockSchedule(
        id: 's1',
        name: 'B',
        appIdentifiers: [],
        weekdays: [1],
        startTime: const TimeOfDay(hour: 0, minute: 0),
        endTime: const TimeOfDay(hour: 0, minute: 0),
      );

      expect(a.hashCode, equals(b.hashCode));
    });

    test('copyWith replaces fields correctly', () {
      final original = BlockSchedule(
        id: 's1',
        name: 'Original',
        appIdentifiers: ['com.a'],
        weekdays: [1],
        startTime: const TimeOfDay(hour: 8, minute: 0),
        endTime: const TimeOfDay(hour: 17, minute: 0),
        enabled: true,
      );

      final copy = original.copyWith(name: 'Copy', enabled: false);

      expect(copy.id, 's1');
      expect(copy.name, 'Copy');
      expect(copy.enabled, isFalse);
      expect(copy.appIdentifiers, ['com.a']);
    });

    test('constructor throws ArgumentError for invalid weekday < 1', () {
      expect(
        () => BlockSchedule(
          id: 's1',
          name: 'Test',
          appIdentifiers: ['com.a'],
          weekdays: [0],
          startTime: const TimeOfDay(hour: 0, minute: 0),
          endTime: const TimeOfDay(hour: 0, minute: 0),
        ),
        throwsArgumentError,
      );
    });

    test('constructor throws ArgumentError for invalid weekday > 7', () {
      expect(
        () => BlockSchedule(
          id: 's1',
          name: 'Test',
          appIdentifiers: ['com.a'],
          weekdays: [8],
          startTime: const TimeOfDay(hour: 0, minute: 0),
          endTime: const TimeOfDay(hour: 0, minute: 0),
        ),
        throwsArgumentError,
      );
    });

    test('constructor throws ArgumentError for negative weekday', () {
      expect(
        () => BlockSchedule(
          id: 's1',
          name: 'Test',
          appIdentifiers: ['com.a'],
          weekdays: [-1],
          startTime: const TimeOfDay(hour: 0, minute: 0),
          endTime: const TimeOfDay(hour: 0, minute: 0),
        ),
        throwsArgumentError,
      );
    });

    test('constructor accepts valid weekdays 1-7', () {
      for (var day = 1; day <= 7; day++) {
        expect(
          () => BlockSchedule(
            id: 's$day',
            name: 'Test',
            appIdentifiers: ['com.a'],
            weekdays: [day],
            startTime: const TimeOfDay(hour: 0, minute: 0),
            endTime: const TimeOfDay(hour: 0, minute: 0),
          ),
          returnsNormally,
        );
      }
    });

    test('toString contains id and name', () {
      final schedule = BlockSchedule(
        id: 's1',
        name: 'Work',
        appIdentifiers: [],
        weekdays: [1],
        startTime: const TimeOfDay(hour: 0, minute: 0),
        endTime: const TimeOfDay(hour: 0, minute: 0),
      );
      final str = schedule.toString();
      expect(str, contains('s1'));
      expect(str, contains('Work'));
    });

    // One-time schedule tests
    test('recurring schedule: throws if no weekdays provided', () {
      expect(
        () => BlockSchedule(
          id: 's1',
          name: 'Recurring',
          appIdentifiers: ['com.a'],
          // weekdays defaults to []
          startTime: const TimeOfDay(hour: 9, minute: 0),
          endTime: const TimeOfDay(hour: 17, minute: 0),
          // scheduleDate is null (recurring)
        ),
        throwsArgumentError,
      );
    });
  });

  // =========================================================================
  // BlockProfile
  // =========================================================================

  group('BlockProfile', () {
    test('fromMap creates correct instance without schedules', () {
      final map = <String, dynamic>{
        'id': 'prof-1',
        'name': 'Work Mode',
        'appIdentifiers': ['com.a', 'com.b'],
        'isActive': true,
      };

      final profile = BlockProfile.fromMap(map);

      expect(profile.id, 'prof-1');
      expect(profile.name, 'Work Mode');
      expect(profile.appIdentifiers, ['com.a', 'com.b']);
      expect(profile.schedules, isEmpty);
      expect(profile.isActive, isTrue);
    });

    test('fromMap creates instance with embedded schedules', () {
      final map = <String, dynamic>{
        'id': 'prof-2',
        'name': 'Sleep Mode',
        'appIdentifiers': ['com.c'],
        'schedules': [
          {
            'id': 'sched-inner',
            'name': 'Night',
            'appIdentifiers': ['com.c'],
            'weekdays': [1, 2, 3, 4, 5, 6, 7],
            'startHour': 22,
            'startMinute': 0,
            'endHour': 7,
            'endMinute': 0,
            'enabled': true,
          },
        ],
        'isActive': false,
      };

      final profile = BlockProfile.fromMap(map);

      expect(profile.schedules, hasLength(1));
      expect(profile.schedules.first.id, 'sched-inner');
      expect(profile.schedules.first.name, 'Night');
    });

    test('fromMap defaults isActive to false', () {
      final map = <String, dynamic>{
        'id': 'p1',
        'name': 'Test',
        'appIdentifiers': <String>[],
      };

      final profile = BlockProfile.fromMap(map);
      expect(profile.isActive, isFalse);
    });

    test('toMap produces correct structure', () {
      final profile = BlockProfile(
        id: 'p1',
        name: 'Test',
        appIdentifiers: ['com.a'],
        schedules: [
          BlockSchedule(
            id: 's1',
            name: 'Inner',
            appIdentifiers: ['com.a'],
            weekdays: [1],
            startTime: const TimeOfDay(hour: 9, minute: 0),
            endTime: const TimeOfDay(hour: 17, minute: 0),
          ),
        ],
        isActive: true,
      );

      final map = profile.toMap();

      expect(map['id'], 'p1');
      expect(map['name'], 'Test');
      expect(map['appIdentifiers'], ['com.a']);
      expect(map['isActive'], isTrue);
      expect(map['schedules'], isList);
      expect((map['schedules'] as List), hasLength(1));
    });

    test('fromMap -> toMap roundtrip', () {
      final original = <String, dynamic>{
        'id': 'rt-p',
        'name': 'Roundtrip Profile',
        'appIdentifiers': ['com.x', 'com.y'],
        'schedules': <Map<String, dynamic>>[],
        'isActive': false,
      };

      final roundtripped = BlockProfile.fromMap(original).toMap();

      expect(roundtripped['id'], original['id']);
      expect(roundtripped['name'], original['name']);
      expect(roundtripped['appIdentifiers'], original['appIdentifiers']);
      expect(roundtripped['isActive'], original['isActive']);
    });

    test('equality is based on id', () {
      const a = BlockProfile(id: 'p1', name: 'A', appIdentifiers: []);
      const b = BlockProfile(id: 'p1', name: 'B', appIdentifiers: ['com.x']);
      const c = BlockProfile(id: 'p2', name: 'A', appIdentifiers: []);

      expect(a, equals(b));
      expect(a, isNot(equals(c)));
    });

    test('hashCode is based on id', () {
      const a = BlockProfile(id: 'p1', name: 'A', appIdentifiers: []);
      const b = BlockProfile(id: 'p1', name: 'B', appIdentifiers: []);

      expect(a.hashCode, equals(b.hashCode));
    });

    test('copyWith replaces fields correctly', () {
      const original = BlockProfile(
        id: 'p1',
        name: 'Original',
        appIdentifiers: ['com.a'],
        isActive: false,
      );

      final copy = original.copyWith(name: 'Copy', isActive: true);

      expect(copy.id, 'p1');
      expect(copy.name, 'Copy');
      expect(copy.isActive, isTrue);
      expect(copy.appIdentifiers, ['com.a']);
    });

    test('toString contains id and name', () {
      const profile = BlockProfile(id: 'p1', name: 'Work', appIdentifiers: []);
      final str = profile.toString();
      expect(str, contains('p1'));
      expect(str, contains('Work'));
    });
  });

  // =========================================================================
  // BlockScreenConfig
  // =========================================================================

  group('BlockScreenConfig', () {
    test('fromMap creates instance with all fields', () {
      final map = <String, dynamic>{
        'title': 'Blocked',
        'subtitle': 'Focus Time',
        'message': 'Stay focused!',
        'backgroundColor': 0xFF112233,
        'iconAssetPath': 'assets/lock.png',
      };

      final config = BlockScreenConfig.fromMap(map);

      expect(config.title, 'Blocked');
      expect(config.subtitle, 'Focus Time');
      expect(config.message, 'Stay focused!');
      expect(config.backgroundColor, const Color(0xFF112233));
      expect(config.iconAssetPath, 'assets/lock.png');
    });

    test('fromMap creates instance with null fields', () {
      final map = <String, dynamic>{
        'title': null,
        'subtitle': null,
        'message': null,
        'backgroundColor': null,
        'iconAssetPath': null,
      };

      final config = BlockScreenConfig.fromMap(map);

      expect(config.title, isNull);
      expect(config.subtitle, isNull);
      expect(config.message, isNull);
      expect(config.backgroundColor, isNull);
      expect(config.iconAssetPath, isNull);
    });

    test('fromMap -> toMap roundtrip with all fields', () {
      final original = <String, dynamic>{
        'title': 'Test',
        'subtitle': 'Sub',
        'message': 'Message',
        'backgroundColor': 0xFFAABBCC,
        'iconAssetPath': 'icon.png',
      };

      final roundtripped = BlockScreenConfig.fromMap(original).toMap();

      expect(roundtripped['title'], original['title']);
      expect(roundtripped['subtitle'], original['subtitle']);
      expect(roundtripped['message'], original['message']);
      expect(roundtripped['backgroundColor'], original['backgroundColor']);
      expect(roundtripped['iconAssetPath'], original['iconAssetPath']);
    });

    test('toMap with all fields set', () {
      const config = BlockScreenConfig(
        title: 'Blocked',
        subtitle: 'Focus Time',
        message: 'Stay focused!',
        backgroundColor: Color(0xFF112233),
        iconAssetPath: 'assets/lock.png',
      );

      final map = config.toMap();

      expect(map['title'], 'Blocked');
      expect(map['subtitle'], 'Focus Time');
      expect(map['message'], 'Stay focused!');
      expect(map['backgroundColor'], const Color(0xFF112233).toARGB32());
      expect(map['iconAssetPath'], 'assets/lock.png');
    });

    test('toMap with null fields', () {
      const config = BlockScreenConfig();
      final map = config.toMap();

      expect(map['title'], isNull);
      expect(map['subtitle'], isNull);
      expect(map['message'], isNull);
      expect(map['backgroundColor'], isNull);
      expect(map['iconAssetPath'], isNull);
    });

    test('toString contains title and subtitle', () {
      const config = BlockScreenConfig(title: 'T', subtitle: 'S');
      final str = config.toString();
      expect(str, contains('T'));
      expect(str, contains('S'));
    });
  });

  // =========================================================================
  // Enum values
  // =========================================================================

  group('BlockStatus enum', () {
    test('has expected values', () {
      expect(BlockStatus.values, hasLength(3));
      expect(BlockStatus.values, contains(BlockStatus.blocked));
      expect(BlockStatus.values, contains(BlockStatus.unblocked));
      expect(BlockStatus.values, contains(BlockStatus.scheduled));
    });

    test('byName parses correctly', () {
      expect(BlockStatus.values.byName('blocked'), BlockStatus.blocked);
      expect(BlockStatus.values.byName('unblocked'), BlockStatus.unblocked);
      expect(BlockStatus.values.byName('scheduled'), BlockStatus.scheduled);
    });
  });

  group('BlockerPermissionStatus enum', () {
    test('has expected values', () {
      expect(BlockerPermissionStatus.values, hasLength(3));
      expect(
        BlockerPermissionStatus.values,
        contains(BlockerPermissionStatus.granted),
      );
      expect(
        BlockerPermissionStatus.values,
        contains(BlockerPermissionStatus.denied),
      );
      expect(
        BlockerPermissionStatus.values,
        contains(BlockerPermissionStatus.restricted),
      );
    });
  });

  group('BlockEventType enum', () {
    test('has expected values', () {
      expect(BlockEventType.values, hasLength(7));
      expect(BlockEventType.values, contains(BlockEventType.blocked));
      expect(BlockEventType.values, contains(BlockEventType.unblocked));
      expect(BlockEventType.values, contains(BlockEventType.attemptedAccess));
      expect(BlockEventType.values, contains(BlockEventType.scheduleActivated));
      expect(
        BlockEventType.values,
        contains(BlockEventType.scheduleDeactivated),
      );
      expect(BlockEventType.values, contains(BlockEventType.profileActivated));
      expect(
        BlockEventType.values,
        contains(BlockEventType.profileDeactivated),
      );
    });

    test('byName parses all values', () {
      for (final value in BlockEventType.values) {
        expect(BlockEventType.values.byName(value.name), value);
      }
    });
  });
}
