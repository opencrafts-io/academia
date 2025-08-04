import 'package:equatable/equatable.dart';

class Ticket extends Equatable {
  final String id;
  final String attendeeId;
  final String eventId;
  final String paymentCode;
  final DateTime createdAt;

  const Ticket({
    required this.id,
    required this.attendeeId,
    required this.eventId,
    required this.paymentCode,
    required this.createdAt,
  });

  Ticket copyWith({
    String? id,
    String? attendeeId,
    String? eventId,
    String? paymentCode,
    DateTime? createdAt,
  }) {
    return Ticket(
      id: id ?? this.id,
      attendeeId: attendeeId ?? this.attendeeId,
      eventId: eventId ?? this.eventId,
      paymentCode: paymentCode ?? this.paymentCode,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, attendeeId, eventId, paymentCode, createdAt];

  @override
  bool? get stringify => true;
}
