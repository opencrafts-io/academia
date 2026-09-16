// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entitlement_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EntitlementDto _$EntitlementDtoFromJson(Map<String, dynamic> json) =>
    _EntitlementDto(
      createdAt: DateTime.parse(json['created_at'] as String),
      description: json['description'] as String?,
      key: json['key'] as String,
      planCode: json['plan_code'] as String,
      unit: json['unit'] as String,
      value: (json['value'] as num).toInt(),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$EntitlementDtoToJson(_EntitlementDto instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'description': instance.description,
      'key': instance.key,
      'plan_code': instance.planCode,
      'unit': instance.unit,
      'value': instance.value,
      'updated_at': instance.updatedAt.toIso8601String(),
    };
