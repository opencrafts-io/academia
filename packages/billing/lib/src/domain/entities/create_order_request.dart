/// The minimum information required to open an order before web checkout.
class CreateOrderRequest {
  const CreateOrderRequest({
    required this.currency,
    this.expiresAt,
    this.metadata = const [],
    this.userId,
  });

  final String currency;
  final DateTime? expiresAt;
  final List<int> metadata;
  final String? userId;
}
