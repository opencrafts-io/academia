import 'package:academia/features/sherehe/domain/domain.dart';

class ConfirmPaymentArgs {
  final Event? event;
  final List<Attendee>? attendees;

  const ConfirmPaymentArgs({this.event, this.attendees});
}
