/// The order that should be handed off to browser checkout.
class CreateCheckoutSessionRequest {
  const CreateCheckoutSessionRequest({required this.orderId});

  final String orderId;
}
