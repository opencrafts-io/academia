import 'local_notification_action.dart';
import 'local_notification_channel.dart';
import 'local_notification_category.dart';
import 'local_notification_presentation.dart';
import 'local_notification_schedule.dart';

class LocalNotificationRequest {
  const LocalNotificationRequest({
    required this.id,
    required this.channel,
    required this.title,
    required this.body,
    this.summary,
    this.payload = const {},
    this.schedule,
    this.actions = const [],
    this.category = LocalNotificationCategory.reminder,
    this.presentation = const LocalNotificationPresentation(),
  });

  final int id;
  final LocalNotificationChannel channel;
  final String title;
  final String body;
  final String? summary;
  final Map<String, String> payload;
  final LocalNotificationSchedule? schedule;
  final List<LocalNotificationAction> actions;
  final LocalNotificationCategory category;
  final LocalNotificationPresentation presentation;
}
