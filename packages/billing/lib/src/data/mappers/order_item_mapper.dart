import 'package:billing/src/data/data.dart';
import 'package:billing/src/domain/domain.dart' as domain;
import 'package:database/database.dart' as database;

extension OrderItemDtoMapper on OrderItemDto {
  domain.OrderItem toDomain() => domain.OrderItem(
    id: id,
    orderId: orderId,
    planId: planId,
    quantity: quantity,
    unitPrice: unitPrice,
    discount: discount,
    tax: tax,
    addedBy: addedBy,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension CreateOrderMapper on domain.CreateOrderRequest {
  CreateOrderDto toDto() => CreateOrderDto(
    currency: currency,
    expiresAt: expiresAt,
    metadata: metadata,
    userId: userId,
  );
}

extension CreateOrderItemMapper on domain.CreateOrderItemRequest {
  CreateOrderItemDto toDto() => CreateOrderItemDto(
    orderId: orderId,
    planId: planId,
    quantity: quantity,
    unitPrice: unitPrice,
    discount: discount,
    tax: tax,
    addedBy: addedBy,
  );
}

extension OrderItemEntityMapper on database.BillingOrderItem {
  domain.OrderItem toDomain() => domain.OrderItem(
    id: id,
    orderId: orderId,
    planId: planId,
    quantity: quantity,
    unitPrice: unitPrice,
    discount: discount,
    tax: tax,
    addedBy: addedBy,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension OrderItemDomainMapper on domain.OrderItem {
  database.BillingOrderItemsCompanion toCompanion() =>
      database.BillingOrderItemsCompanion(
        id: database.Value(id),
        orderId: database.Value(orderId),
        planId: database.Value(planId),
        quantity: database.Value(quantity),
        unitPrice: database.Value(unitPrice),
        discount: database.Value(discount),
        tax: database.Value(tax),
        addedBy: database.Value(addedBy),
        createdAt: database.Value(createdAt),
        updatedAt: database.Value(updatedAt),
      );
}
