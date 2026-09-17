// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_dao.dart';

// ignore_for_file: type=lint
mixin _$SubscriptionDaoMixin on DatabaseAccessor<AppDatabaseV2> {
  $BillingSubscriptionsTable get billingSubscriptions =>
      attachedDatabase.billingSubscriptions;
  $BillingSubscriptionStatusesTable get billingSubscriptionStatuses =>
      attachedDatabase.billingSubscriptionStatuses;
  SubscriptionDaoManager get managers => SubscriptionDaoManager(this);
}

class SubscriptionDaoManager {
  final _$SubscriptionDaoMixin _db;
  SubscriptionDaoManager(this._db);
  $$BillingSubscriptionsTableTableManager get billingSubscriptions =>
      $$BillingSubscriptionsTableTableManager(
        _db.attachedDatabase,
        _db.billingSubscriptions,
      );
  $$BillingSubscriptionStatusesTableTableManager
  get billingSubscriptionStatuses =>
      $$BillingSubscriptionStatusesTableTableManager(
        _db.attachedDatabase,
        _db.billingSubscriptionStatuses,
      );
}
