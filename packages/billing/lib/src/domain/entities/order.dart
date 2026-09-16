import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';

@freezed
abstract class Order with _$Order {
  const factory Order({
    required String id,
    required String currency,
    required int discount,
    required DateTime? expiresAt,
    required List<int> metadata,
    required DateTime? paidAt,
    required String status,
    required int subtotal,
    required int tax,
    required int total,
    required String? userId,
    required DateTime? cancelledAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Order;
}
