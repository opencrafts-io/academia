import 'package:flutter_test/flutter_test.dart';
import 'package:lock_in/src/domain/lock_rule.dart';

void main() {
  const instagram = BlockedApp(
    identifier: 'com.instagram.android',
    displayName: 'Instagram',
  );

  group('LockRule', () {
    test('recognizes an overnight weekday window', () {
      const rule = LockRule(
        id: 'wind-down',
        name: 'Wind down',
        apps: [instagram],
        weekdays: {DateTime.monday},
        startMinutes: 22 * 60,
        endMinutes: 7 * 60,
      );

      expect(rule.isActiveAt(DateTime(2026, 9, 7, 23)), isTrue);
      expect(rule.isActiveAt(DateTime(2026, 9, 8, 6, 59)), isTrue);
      expect(rule.isActiveAt(DateTime(2026, 9, 8, 7)), isFalse);
    });

    test('describes the active window and its next-day end time', () {
      const rule = LockRule(
        id: 'wind-down',
        name: 'Wind down',
        apps: [instagram],
        weekdays: {DateTime.monday},
        startMinutes: 22 * 60,
        endMinutes: 7 * 60,
      );
      final window = rule.activeWindowAt(DateTime(2026, 9, 8, 1, 30));

      expect(window?.startsAt, DateTime(2026, 9, 7, 22));
      expect(window?.endsAt, DateTime(2026, 9, 8, 7));
      expect(
        window?.progressAt(DateTime(2026, 9, 8, 1, 30)),
        closeTo(.39, .01),
      );
    });

    test('reports conflicting enabled rules that share an app', () {
      const morning = LockRule(
        id: 'work',
        name: 'Work',
        apps: [instagram],
        weekdays: {DateTime.monday},
        startMinutes: 9 * 60,
        endMinutes: 17 * 60,
      );
      const overlap = LockRule(
        id: 'study',
        name: 'Study',
        apps: [instagram],
        weekdays: {DateTime.monday},
        startMinutes: 16 * 60,
        endMinutes: 18 * 60,
      );

      expect(morning.conflictsWith(overlap), isTrue);
    });

    test('allows rules that share an app but have separate windows', () {
      const morning = LockRule(
        id: 'work',
        name: 'Work',
        apps: [instagram],
        weekdays: {DateTime.monday},
        startMinutes: 9 * 60,
        endMinutes: 17 * 60,
      );
      const evening = LockRule(
        id: 'study',
        name: 'Study',
        apps: [instagram],
        weekdays: {DateTime.monday},
        startMinutes: 18 * 60,
        endMinutes: 20 * 60,
      );

      expect(morning.conflictsWith(evening), isFalse);
    });
  });
}
