import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_dto.freezed.dart';
part 'subscription_dto.g.dart';

@freezed
abstract class SubscriptionDto with _$SubscriptionDto {
  const factory SubscriptionDto({
    required int id,
    @JsonKey(name: 'plan_code') required String planCode,
    @JsonKey(name: 'plan_id') required int planId,
    @JsonKey(name: 'plan_name') required String planName,
    required String status,
    @JsonKey(name: 'cancel_at_period_end') required bool cancelAtPeriodEnd,
    @JsonKey(name: 'cancelled_at') required DateTime? cancelledAt,
    @JsonKey(name: 'current_period_end') required DateTime currentPeriodEnd,
    @JsonKey(name: 'current_period_start') required DateTime currentPeriodStart,
    @JsonKey(name: 'started_at') required DateTime startedAt,
  }) = _SubscriptionDto;

  factory SubscriptionDto.fromJson(Map<String, Object?> json) =>
      _$SubscriptionDtoFromJson(json);
}
