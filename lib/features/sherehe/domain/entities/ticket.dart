class Ticket{
  final String id;
  final String attendeeId;
  final String eventId;
  final String paymentCode;
  final String createdAt;
//
  const Ticket({
    required this.id,
    required this.attendeeId,
    required this.eventId,
    required this.paymentCode,
    required this.createdAt,
  });
}