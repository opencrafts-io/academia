import 'package:billing/src/data/data.dart';
import 'package:billing/src/domain/domain.dart' as domain;
import 'package:database/database.dart' as database;

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

  database.BillingSubscriptionsCompanion toCompanion() {
    return database.BillingSubscriptionsCompanion(
      id: database.Value(id),
      planCode: database.Value(planCode),
      planId: database.Value(planId),
      planName: database.Value(planName),
      status: database.Value(status),
      cancelAtPeriodEnd: database.Value(cancelAtPeriodEnd),
      cancelledAt: database.Value(cancelledAt),
      currentPeriodEnd: database.Value(currentPeriodEnd),
      currentPeriodStart: database.Value(currentPeriodStart),
      startedAt: database.Value(startedAt),
    );
  }
}

extension SubscriptionMapper on domain.Subscription {
  SubscriptionDto toDto() {
    return SubscriptionDto(
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

extension SubscriptionStatusMapper on domain.SubscriptionStatus {
  SubscriptionStatusDto toDto() {
    return SubscriptionStatusDto(
      active: active,
      subscription: subscription?.toDto(),
    );
  }
}

extension BillingSubscriptionMapper on database.BillingSubscription {
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

extension SubscriptionStatusDtoCacheMapper on SubscriptionStatusDto {
  database.BillingSubscriptionStatusesCompanion toStatusCompanion() {
    return database.BillingSubscriptionStatusesCompanion(
      id: const database.Value(1),
      active: database.Value(active),
      subscriptionId: database.Value(subscription?.id),
      updatedAt: database.Value(DateTime.now().toUtc()),
    );
  }
}

extension BillingSubscriptionStatusMapper
    on database.BillingSubscriptionStatuse {
  Future<domain.SubscriptionStatus> toDomain(
    database.SubscriptionDao dao,
  ) async {
    final subscription = subscriptionId == null
        ? null
        : await dao.getSubscriptionById(subscriptionId!);

    return domain.SubscriptionStatus(
      active: active,
      subscription: subscription?.toDomain(),
    );
  }
}
