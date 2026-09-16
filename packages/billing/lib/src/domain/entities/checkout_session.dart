/// Short-lived browser checkout handoff returned by the billing API.
class CheckoutSession {
  const CheckoutSession({
    required this.orderId,
    required this.checkoutUrl,
    required this.expiresAt,
  });

  final String orderId;
  final String checkoutUrl;
  final DateTime expiresAt;
}
