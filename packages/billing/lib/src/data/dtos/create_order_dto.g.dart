// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateOrderDto _$CreateOrderDtoFromJson(Map<String, dynamic> json) =>
    _CreateOrderDto(
      currency: json['currency'] as String,
      expiresAt: json['expires_at'] == null
          ? null
          : DateTime.parse(json['expires_at'] as String),
      metadata:
          (json['metadata'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const <int>[],
      userId: json['user_id'] as String?,
    );

Map<String, dynamic> _$CreateOrderDtoToJson(_CreateOrderDto instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'expires_at': instance.expiresAt?.toIso8601String(),
      'metadata': instance.metadata,
      'user_id': instance.userId,
    };
