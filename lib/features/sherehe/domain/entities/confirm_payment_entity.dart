import 'package:academia/features/sherehe/domain/entities/attendee.dart';

class ConfirmPaymentEntity {
  final String status;
  final List<Attendee>? attendees;

  const ConfirmPaymentEntity({required this.status, required this.attendees});
}
