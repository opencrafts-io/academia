enum LocalNotificationActionType { open, silent, dismiss }

class LocalNotificationAction {
  const LocalNotificationAction({
    required this.id,
    required this.label,
    this.type = LocalNotificationActionType.open,
    this.colorValue,
  });

  final String id;
  final String label;
  final LocalNotificationActionType type;
  final int? colorValue;
}
