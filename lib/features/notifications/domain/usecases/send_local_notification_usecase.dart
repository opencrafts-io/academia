import 'package:academia/core/core.dart';
import 'package:academia/features/notifications/notifications.dart';
import 'package:dartz/dartz.dart';

class SendLocalNotificationParams {
  final String title;
  final String body;
  final Map<String, dynamic>? data;

  SendLocalNotificationParams({
    required this.title,
    required this.body,
    this.data,
  });
}

class SendLocalNotificationUsecase implements UseCase<void, SendLocalNotificationParams> {
  final NotificationRepository repository;

  SendLocalNotificationUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(SendLocalNotificationParams params) async {
    return await repository.sendLocalNotification(
      title: params.title,
      body: params.body,
      data: params.data,
    );
  }
}

