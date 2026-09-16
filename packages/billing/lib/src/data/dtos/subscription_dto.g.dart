// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionDto _$SubscriptionDtoFromJson(Map<String, dynamic> json) =>
    _SubscriptionDto(
      id: (json['id'] as num).toInt(),
      planCode: json['plan_code'] as String,
      planId: (json['plan_id'] as num).toInt(),
      planName: json['plan_name'] as String,
      status: json['status'] as String,
      cancelAtPeriodEnd: json['cancel_at_period_end'] as bool,
      cancelledAt: json['cancelled_at'] == null
          ? null
          : DateTime.parse(json['cancelled_at'] as String),
      currentPeriodEnd: DateTime.parse(json['current_period_end'] as String),
      currentPeriodStart: DateTime.parse(
        json['current_period_start'] as String,
      ),
      startedAt: DateTime.parse(json['started_at'] as String),
    );

Map<String, dynamic> _$SubscriptionDtoToJson(_SubscriptionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'plan_code': instance.planCode,
      'plan_id': instance.planId,
      'plan_name': instance.planName,
      'status': instance.status,
      'cancel_at_period_end': instance.cancelAtPeriodEnd,
      'cancelled_at': instance.cancelledAt?.toIso8601String(),
      'current_period_end': instance.currentPeriodEnd.toIso8601String(),
      'current_period_start': instance.currentPeriodStart.toIso8601String(),
      'started_at': instance.startedAt.toIso8601String(),
    };
