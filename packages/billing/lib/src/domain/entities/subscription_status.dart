import 'package:freezed_annotation/freezed_annotation.dart';

import 'subscription.dart';

part 'subscription_status.freezed.dart';

@freezed
abstract class SubscriptionStatus with _$SubscriptionStatus {
  const factory SubscriptionStatus({
    required bool active,
    required Subscription? subscription,
  }) = _SubscriptionStatus;
}
