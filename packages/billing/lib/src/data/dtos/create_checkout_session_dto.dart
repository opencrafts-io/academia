class CreateCheckoutSessionDto {
  const CreateCheckoutSessionDto({required this.orderId});

  final String orderId;

  Map<String, dynamic> toJson() => {'order_id': orderId};
}
