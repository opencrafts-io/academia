import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_dto.freezed.dart';
part 'order_dto.g.dart';

@freezed
abstract class OrderDto with _$OrderDto {
  const factory OrderDto({
    required String id,
    required String currency,
    required int discount,
    @JsonKey(name: 'expires_at')
    required DateTime? expiresAt,
    @Default(<int>[]) List<int> metadata,
    @JsonKey(name: 'paid_at')
    required DateTime? paidAt,
    required String status,
    required int subtotal,
    required int tax,
    required int total,
    @JsonKey(name: 'user_id')
    required String? userId,
    @JsonKey(name: 'cancelled_at')
    required DateTime? cancelledAt,
    @JsonKey(name: 'created_at')
    required DateTime createdAt,
    @JsonKey(name: 'updated_at')
    required DateTime updatedAt,
  }) = _OrderDto;

  factory OrderDto.fromJson(Map<String, Object?> json) =>
      _$OrderDtoFromJson(json);
}
