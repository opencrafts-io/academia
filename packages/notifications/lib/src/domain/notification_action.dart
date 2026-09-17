class NotificationAction {
  const NotificationAction({
    required this.buttonKey,
    required this.payload,
  });

  factory NotificationAction.fromPayload({
    required String? buttonKey,
    required Map<String, dynamic>? payload,
  }) {
    final entries = payload?.entries ?? const <MapEntry<String, dynamic>>[];

    return NotificationAction(
      buttonKey: buttonKey,
      payload: {
        for (final entry in entries)
          if (entry.value is String) entry.key: entry.value as String,
      },
    );
  }

  final String? buttonKey;
  final Map<String, String> payload;
}
