// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_status_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionStatusDto _$SubscriptionStatusDtoFromJson(
  Map<String, dynamic> json,
) => _SubscriptionStatusDto(
  active: json['active'] as bool,
  subscription: json['subscription'] == null
      ? null
      : SubscriptionDto.fromJson(json['subscription'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SubscriptionStatusDtoToJson(
  _SubscriptionStatusDto instance,
) => <String, dynamic>{
  'active': instance.active,
  'subscription': instance.subscription,
};
