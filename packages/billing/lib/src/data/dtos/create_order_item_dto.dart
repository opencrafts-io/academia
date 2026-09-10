import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_order_item_dto.freezed.dart';
part 'create_order_item_dto.g.dart';

@freezed
abstract class CreateOrderItemDto with _$CreateOrderItemDto {
  const factory CreateOrderItemDto({
    @JsonKey(name: 'order_id') required String orderId,
    @JsonKey(name: 'plan_id') required int planId,
    required int quantity,
    @JsonKey(name: 'unit_price') required int unitPrice,
    @Default(0) int discount,
    @Default(0) int tax,
    @JsonKey(name: 'added_by') String? addedBy,
  }) = _CreateOrderItemDto;

  factory CreateOrderItemDto.fromJson(Map<String, Object?> json) =>
      _$CreateOrderItemDtoFromJson(json);
}
