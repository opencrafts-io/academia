import 'package:academia/features/sherehe/domain/entities/attendee.dart';

class ConfirmPaymentEntity {
  final String status;
  final Attendee attendee;

  const ConfirmPaymentEntity({required this.status, required this.attendee});
}
