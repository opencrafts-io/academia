import 'package:billing/src/data/data.dart';
import 'package:billing/src/domain/domain.dart' as domain;

extension OrderDtoMapper on OrderDto {
  domain.Order toDomain() {
    return domain.Order(
      id: id,
      currency: currency,
      discount: discount,
      expiresAt: expiresAt,
      metadata: metadata,
      paidAt: paidAt,
      status: status,
      subtotal: subtotal,
      tax: tax,
      total: total,
      userId: userId,
      cancelledAt: cancelledAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
