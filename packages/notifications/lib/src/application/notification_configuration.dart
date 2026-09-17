class NotificationConfiguration {
  const NotificationConfiguration.enabled({required this.oneSignalAppId})
    : enabled = true;

  const NotificationConfiguration.disabled()
    : enabled = false,
      oneSignalAppId = null;

  final bool enabled;
  final String? oneSignalAppId;
}
