// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderDto _$OrderDtoFromJson(Map<String, dynamic> json) => _OrderDto(
  id: json['id'] as String,
  currency: json['currency'] as String,
  discount: (json['discount'] as num).toInt(),
  expiresAt: json['expires_at'] == null
      ? null
      : DateTime.parse(json['expires_at'] as String),
  metadata:
      (json['metadata'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const <int>[],
  paidAt: json['paid_at'] == null
      ? null
      : DateTime.parse(json['paid_at'] as String),
  status: json['status'] as String,
  subtotal: (json['subtotal'] as num).toInt(),
  tax: (json['tax'] as num).toInt(),
  total: (json['total'] as num).toInt(),
  userId: json['user_id'] as String?,
  cancelledAt: json['cancelled_at'] == null
      ? null
      : DateTime.parse(json['cancelled_at'] as String),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$OrderDtoToJson(_OrderDto instance) => <String, dynamic>{
  'id': instance.id,
  'currency': instance.currency,
  'discount': instance.discount,
  'expires_at': instance.expiresAt?.toIso8601String(),
  'metadata': instance.metadata,
  'paid_at': instance.paidAt?.toIso8601String(),
  'status': instance.status,
  'subtotal': instance.subtotal,
  'tax': instance.tax,
  'total': instance.total,
  'user_id': instance.userId,
  'cancelled_at': instance.cancelledAt?.toIso8601String(),
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
