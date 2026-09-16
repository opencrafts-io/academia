import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_item_dto.freezed.dart';
part 'order_item_dto.g.dart';

@freezed
abstract class OrderItemDto with _$OrderItemDto {
  const factory OrderItemDto({
    required String id,
    @JsonKey(name: 'order_id') required String orderId,
    @JsonKey(name: 'plan_id') required int planId,
    required int quantity,
    @JsonKey(name: 'unit_price') required int unitPrice,
    required int discount,
    required int tax,
    @JsonKey(name: 'added_by') required String addedBy,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _OrderItemDto;

  factory OrderItemDto.fromJson(Map<String, Object?> json) =>
      _$OrderItemDtoFromJson(json);
}
