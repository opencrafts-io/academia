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

  /// Returns the concrete local-time window containing [localTime].
  ///
  /// This gives presentation code an exact end time without duplicating the
  /// weekly and overnight scheduling rules used by the platform blocker.
  LockRuleWindow? activeWindowAt(DateTime localTime) {
    if (!isActiveAt(localTime)) return null;

    final currentMinutes = localTime.hour * 60 + localTime.minute;
    final startsOnPreviousDay = isOvernight && currentMinutes < endMinutes;
    final startDate = startsOnPreviousDay
        ? localTime.subtract(const Duration(days: 1))
        : localTime;
    final startsAt = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
      startMinutes ~/ 60,
      startMinutes % 60,
    );
    final endDate = isOvernight
        ? startsAt.add(const Duration(days: 1))
        : startsAt;
    return LockRuleWindow(
      rule: this,
      startsAt: startsAt,
      endsAt: DateTime(
        endDate.year,
        endDate.month,
        endDate.day,
        endMinutes ~/ 60,
        endMinutes % 60,
      ),
    );
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

/// A concrete occurrence of a recurring [LockRule] in local time.
class LockRuleWindow {
  const LockRuleWindow({
    required this.rule,
    required this.startsAt,
    required this.endsAt,
  });

  final LockRule rule;
  final DateTime startsAt;
  final DateTime endsAt;

  Duration remainingAt(DateTime time) {
    final remaining = endsAt.difference(time);
    return remaining.isNegative ? Duration.zero : remaining;
  }

  /// The fraction of the window elapsed at [time], clamped to 0–1.
  double progressAt(DateTime time) {
    final totalMicroseconds = endsAt.difference(startsAt).inMicroseconds;
    if (totalMicroseconds <= 0) return 1;
    final elapsedMicroseconds = time.difference(startsAt).inMicroseconds;
    return (elapsedMicroseconds / totalMicroseconds).clamp(0, 1).toDouble();
  }

  BlockedApp? appWithIdentifier(String identifier) {
    for (final app in rule.apps) {
      if (app.identifier == identifier) return app;
    }
    return null;
  }
}

class _WeeklyInterval {
  const _WeeklyInterval(this.start, this.end);

  final int start;
  final int end;
}
