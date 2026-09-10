// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateOrderItemDto _$CreateOrderItemDtoFromJson(Map<String, dynamic> json) =>
    _CreateOrderItemDto(
      orderId: json['order_id'] as String,
      planId: (json['plan_id'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      unitPrice: (json['unit_price'] as num).toInt(),
      discount: (json['discount'] as num?)?.toInt() ?? 0,
      tax: (json['tax'] as num?)?.toInt() ?? 0,
      addedBy: json['added_by'] as String?,
    );

Map<String, dynamic> _$CreateOrderItemDtoToJson(_CreateOrderItemDto instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'plan_id': instance.planId,
      'quantity': instance.quantity,
      'unit_price': instance.unitPrice,
      'discount': instance.discount,
      'tax': instance.tax,
      'added_by': instance.addedBy,
    };
