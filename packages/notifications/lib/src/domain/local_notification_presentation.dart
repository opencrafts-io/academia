enum LocalNotificationLayout { standard, bigText }

class LocalNotificationPresentation {
  const LocalNotificationPresentation({
    this.autoDismissible = true,
    this.showInBackground = true,
    this.showInForeground = true,
    this.wakeUpScreen = false,
    this.criticalAlert = false,
    this.fullScreenIntent = false,
    this.locked = false,
    this.keepOnTop = false,
    this.layout = LocalNotificationLayout.standard,
    this.largeIcon,
    this.roundedLargeIcon = false,
    this.colorValue,
    this.backgroundColorValue,
    this.chronometer,
  });

  final bool autoDismissible;
  final bool showInBackground;
  final bool showInForeground;
  final bool wakeUpScreen;
  final bool criticalAlert;
  final bool fullScreenIntent;
  final bool locked;
  final bool keepOnTop;
  final LocalNotificationLayout layout;
  final String? largeIcon;
  final bool roundedLargeIcon;
  final int? colorValue;
  final int? backgroundColorValue;
  final Duration? chronometer;
}
