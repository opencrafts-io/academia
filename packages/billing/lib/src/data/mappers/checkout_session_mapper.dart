import 'package:billing/src/data/dtos/checkout_session_dto.dart';
import 'package:billing/src/domain/entities/checkout_session.dart';

extension CheckoutSessionDtoMapper on CheckoutSessionDto {
  CheckoutSession toDomain(String orderId) => CheckoutSession(
    orderId: orderId,
    checkoutUrl: checkoutUrl,
    expiresAt: expiresAt,
  );
}
