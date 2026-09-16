// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlanDto _$PlanDtoFromJson(Map<String, dynamic> json) => _PlanDto(
  id: (json['id'] as num?)?.toInt(),
  active: json['active'] as bool,
  billingIntervalDays: (json['billing_interval_days'] as num).toInt(),
  code: json['code'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  createdBy: json['created_by'] as String,
  currency: json['currency'] as String,
  description: json['description'] as String,
  name: json['name'] as String,
  price: (json['price'] as num).toInt(),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  visible: json['visible'] as bool,
);

Map<String, dynamic> _$PlanDtoToJson(_PlanDto instance) => <String, dynamic>{
  'id': instance.id,
  'active': instance.active,
  'billing_interval_days': instance.billingIntervalDays,
  'code': instance.code,
  'created_at': instance.createdAt.toIso8601String(),
  'created_by': instance.createdBy,
  'currency': instance.currency,
  'description': instance.description,
  'name': instance.name,
  'price': instance.price,
  'updated_at': instance.updatedAt.toIso8601String(),
  'visible': instance.visible,
};
