abstract class PurchaseTicketResult {
  final String message;
  const PurchaseTicketResult(this.message);
}

class FreeTicketSuccess extends PurchaseTicketResult {
  const FreeTicketSuccess({required String message}) : super(message);
}

class PaidTicketInitiated extends PurchaseTicketResult {
  final String transactionId;

  const PaidTicketInitiated({
    required String message,
    required this.transactionId,
  }) : super(message);
}
