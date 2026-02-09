abstract class PurchaseTicketResult {
  final String message;
  const PurchaseTicketResult(this.message);
}

class FreeTicketSuccess extends PurchaseTicketResult {
  final String attendeeId;

  const FreeTicketSuccess({
    required String message,
    required this.attendeeId,
  }) : super(message);
}

class PaidTicketInitiated extends PurchaseTicketResult {
  final String transactionId;

  const PaidTicketInitiated({
    required String message,
    required this.transactionId,
  }) : super(message);
}
