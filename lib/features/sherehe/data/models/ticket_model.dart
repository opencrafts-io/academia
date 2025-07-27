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
      id: json['id'],
      attendeeId: json['attendeeid'],
      eventId: json['eventid'],
      paymentCode: json['paymentcode'],
      createdAt: json['createdat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attendeeid': attendeeId,
      'eventid': eventId,
      'paymentcode': paymentCode,
      'createdat': createdAt,
    };
  }
}