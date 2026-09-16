class CheckoutSessionDto {
  const CheckoutSessionDto({
    required this.checkoutUrl,
    required this.expiresAt,
  });

  factory CheckoutSessionDto.fromJson(Map<String, dynamic> json) {
    return CheckoutSessionDto(
      checkoutUrl: json['checkout_url'] as String,
      expiresAt: DateTime.parse(json['expires_at'] as String),
    );
  }

  final String checkoutUrl;
  final DateTime expiresAt;
}
