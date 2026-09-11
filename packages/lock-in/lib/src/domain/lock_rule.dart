import 'dart:typed_data';

/// An app selected by the user for blocking.
class BlockedApp {
  const BlockedApp({
    required this.identifier,
    required this.displayName,
    this.icon,
  });

  final String identifier;
  final String displayName;
  final Uint8List? icon;

  @override
  bool operator ==(Object other) =>
      other is BlockedApp && other.identifier == identifier;

  @override
  int get hashCode => identifier.hashCode;
}

/// A named, weekly recurring app-blocking window.
///
/// Times are stored as minutes after local midnight. A window whose end is at
/// or before its start finishes on the following calendar day.
class LockRule {
  const LockRule({
    required this.id,
    required this.name,
    required this.apps,
    required this.weekdays,
    required this.startMinutes,
    required this.endMinutes,
    this.enabled = true,
  });

  final String id;
  final String name;
  final List<BlockedApp> apps;
  final Set<int> weekdays;
  final int startMinutes;
  final int endMinutes;
  final bool enabled;

  static const minutesPerDay = Duration.minutesPerDay;
  static const minutesPerWeek = 7 * minutesPerDay;

  bool get isOvernight => endMinutes <= startMinutes;

  bool get isValid =>
      id.trim().isNotEmpty &&
      name.trim().isNotEmpty &&
      apps.isNotEmpty &&
      weekdays.isNotEmpty &&
      weekdays.every(
        (day) => day >= DateTime.monday && day <= DateTime.sunday,
      ) &&
      startMinutes >= 0 &&
      startMinutes < minutesPerDay &&
      endMinutes >= 0 &&
      endMinutes < minutesPerDay &&
      startMinutes != endMinutes;

  bool isActiveAt(DateTime localTime) {
    if (!enabled || !isValid) return false;

    final currentMinutes = localTime.hour * 60 + localTime.minute;
    final weekday = localTime.weekday;

    if (weekdays.contains(weekday) &&
        currentMinutes >= startMinutes &&
        (!isOvernight || currentMinutes < minutesPerDay)) {
      if (!isOvernight && currentMinutes >= endMinutes) return false;
      return true;
    }

    if (!isOvernight || currentMinutes >= endMinutes) return false;
    final priorWeekday = weekday == DateTime.monday
        ? DateTime.sunday
        : weekday - 1;
    return weekdays.contains(priorWeekday);
  }

  bool conflictsWith(LockRule other) {
    if (!enabled || !other.enabled) return false;
    if (!apps.any(other.apps.contains)) return false;

    for (final interval in _intervals) {
      for (final otherInterval in other._intervals) {
        for (final offset in const [-minutesPerWeek, 0, minutesPerWeek]) {
          final shiftedStart = otherInterval.start + offset;
          final shiftedEnd = otherInterval.end + offset;
          if (interval.start < shiftedEnd && shiftedStart < interval.end) {
            return true;
          }
        }
      }
    }
    return false;
  }

  Iterable<_WeeklyInterval> get _intervals sync* {
    for (final weekday in weekdays) {
      final start = (weekday - DateTime.monday) * minutesPerDay + startMinutes;
      final duration = isOvernight
          ? minutesPerDay - startMinutes + endMinutes
          : endMinutes - startMinutes;
      yield _WeeklyInterval(start, start + duration);
    }
  }

  @override
  bool operator ==(Object other) {
    if (other is! LockRule ||
        id != other.id ||
        name != other.name ||
        startMinutes != other.startMinutes ||
        endMinutes != other.endMinutes ||
        enabled != other.enabled ||
        weekdays.length != other.weekdays.length ||
        apps.length != other.apps.length) {
      return false;
    }
    return weekdays.containsAll(other.weekdays) &&
        apps.every(other.apps.contains);
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    Object.hashAll(apps),
    Object.hashAll(weekdays),
    startMinutes,
    endMinutes,
    enabled,
  );
}

class _WeeklyInterval {
  const _WeeklyInterval(this.start, this.end);

  final int start;
  final int end;
}
