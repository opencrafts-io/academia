class LocalNotificationSchedule {
  const LocalNotificationSchedule.at(
    this.at, {
    this.precise = false,
    this.allowWhileIdle = true,
  });

  final DateTime at;
  final bool precise;
  final bool allowWhileIdle;
}
