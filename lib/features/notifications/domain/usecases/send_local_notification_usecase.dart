import 'package:academia/core/core.dart';
import 'package:academia/features/notifications/notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dartz/dartz.dart';

class SendLocalNotificationParams {
  SendLocalNotificationParams({
    required this.content,
    this.schedule,
    this.actionButtons,
    this.localizations,
  });
  NotificationContent content;
  NotificationCalendar? schedule;
  List<NotificationActionButton>? actionButtons;
  Map<String, NotificationLocalization>? localizations;
}

class SendLocalNotificationUsecase
    implements UseCase<void, SendLocalNotificationParams> {
  final NotificationRepository repository;

  SendLocalNotificationUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(SendLocalNotificationParams params) async {
    return await repository.sendLocalNotification(
      schedule: params.schedule,
      content: params.content,
      localizations: params.localizations,
      actionButtons: params.actionButtons,
    );
  }
}
