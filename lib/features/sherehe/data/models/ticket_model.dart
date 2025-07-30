import '../../domain/domain.dart';

class TicketModel extends Ticket {
  const TicketModel({
    required super.id,
    required super.attendeeId,
    required super.eventId,
    required super.paymentCode,
    required super.createdAt,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'].toString(),
      attendeeId: json['attendee_id'].toString(),
      eventId: json['event_id'].toString(),
      paymentCode: json['payment_code'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attendee_id': attendeeId,
      'event_id': eventId,
      'payment_code': paymentCode,
      'created_at': createdAt,
    };
  }
}