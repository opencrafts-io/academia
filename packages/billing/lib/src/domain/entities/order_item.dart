import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_item.freezed.dart';

/// A product or plan attached to an order.
@freezed
abstract class OrderItem with _$OrderItem {
  const factory OrderItem({
    required String id,
    required String orderId,
    required int planId,
    required int quantity,
    required int unitPrice,
    required int discount,
    required int tax,
    required String addedBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _OrderItem;
}
