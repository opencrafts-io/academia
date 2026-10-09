class LocalNotificationSchedule {
  const LocalNotificationSchedule.at(
    this.at, {
    this.precise = false,
    this.allowWhileIdle = true,
    this.weekday,
  });

  final DateTime at;
  final bool precise;
  final bool allowWhileIdle;

  /// When set, schedules this local wall-clock time every week on this day.
  final int? weekday;
}
