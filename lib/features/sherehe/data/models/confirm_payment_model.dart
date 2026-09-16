import 'package:academia/database/database.dart';

class ConfirmPaymentModel {
  final String status;
  final List<AttendeeData>? attendeesData;

  const ConfirmPaymentModel({
    required this.status,
    required this.attendeesData,
  });
}
