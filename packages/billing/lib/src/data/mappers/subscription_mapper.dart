import 'package:billing/src/data/data.dart';
import 'package:billing/src/domain/domain.dart' as domain;

extension SubscriptionDtoMapper on SubscriptionDto {
  domain.Subscription toDomain() {
    return domain.Subscription(
      id: id,
      planCode: planCode,
      planId: planId,
      planName: planName,
      status: status,
      cancelAtPeriodEnd: cancelAtPeriodEnd,
      cancelledAt: cancelledAt,
      currentPeriodEnd: currentPeriodEnd,
      currentPeriodStart: currentPeriodStart,
      startedAt: startedAt,
    );
  }
}

extension SubscriptionStatusDtoMapper on SubscriptionStatusDto {
  domain.SubscriptionStatus toDomain() {
    return domain.SubscriptionStatus(
      active: active,
      subscription: subscription?.toDomain(),
    );
  }
}
