import 'package:billing/src/data/data.dart';
import 'package:billing/src/domain/domain.dart' as domain;
import 'package:database/database.dart' as database;

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

  database.BillingOrdersCompanion toCompanion() {
    return database.BillingOrdersCompanion(
      id: database.Value(id),
      currency: database.Value(currency),
      discount: database.Value(discount),
      expiresAt: database.Value(expiresAt),
      metadata: database.Value(database.OrderDao.encodeMetadata(metadata)),
      paidAt: database.Value(paidAt),
      status: database.Value(status),
      subtotal: database.Value(subtotal),
      tax: database.Value(tax),
      total: database.Value(total),
      userId: database.Value(userId),
      cancelledAt: database.Value(cancelledAt),
      createdAt: database.Value(createdAt),
      updatedAt: database.Value(updatedAt),
    );
  }
}

extension OrderMapper on domain.Order {
  OrderDto toDto() {
    return OrderDto(
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

extension BillingOrderMapper on database.BillingOrder {
  domain.Order toDomain() {
    return domain.Order(
      id: id,
      currency: currency,
      discount: discount,
      expiresAt: expiresAt,
      metadata: database.OrderDao.decodeMetadata(metadata),
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
