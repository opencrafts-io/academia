import 'package:freezed_annotation/freezed_annotation.dart';

import 'subscription_dto.dart';

part 'subscription_status_dto.freezed.dart';
part 'subscription_status_dto.g.dart';

@freezed
abstract class SubscriptionStatusDto with _$SubscriptionStatusDto {
  const factory SubscriptionStatusDto({
    required bool active,
    required SubscriptionDto? subscription,
  }) = _SubscriptionStatusDto;

  factory SubscriptionStatusDto.fromJson(Map<String, Object?> json) =>
      _$SubscriptionStatusDtoFromJson(json);
}
