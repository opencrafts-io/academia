import 'package:flutter_test/flutter_test.dart';

import 'package:billing/billing.dart';

void main() {
  test('exposes the checkout session handoff model', () {
    final session = CheckoutSession(
      orderId: 'ORD-ABC12345',
      checkoutUrl: 'https://checkout.example.test/start?code=abc',
      expiresAt: DateTime.utc(2026, 9, 11, 6, 25, 43),
    );

    expect(session.orderId, 'ORD-ABC12345');
    expect(session.checkoutUrl, contains('/start?code='));
  });
}
