import 'package:database/app_database_v2.dart';
import 'package:database/tables/tables.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

part 'subscription_dao.g.dart';

@injectable
@DriftAccessor(tables: [BillingSubscriptions, BillingSubscriptionStatuses])
class SubscriptionDao extends DatabaseAccessor<AppDatabaseV2>
    with _$SubscriptionDaoMixin {
  SubscriptionDao(super.db);

  Future<BillingSubscriptionStatuse?> getCurrentStatus() {
    return (select(billingSubscriptionStatuses)
          ..where((status) => status.id.equals(_currentStatusId)))
        .getSingleOrNull();
  }

  Future<BillingSubscription?> getSubscriptionById(int id) {
    return (select(billingSubscriptions)
          ..where((subscription) => subscription.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> cacheStatus({
    required BillingSubscriptionStatusesCompanion status,
    BillingSubscriptionsCompanion? subscription,
  }) async {
    await transaction(() async {
      if (subscription != null) {
        await into(billingSubscriptions).insertOnConflictUpdate(subscription);
      }
      await into(billingSubscriptionStatuses).insertOnConflictUpdate(status);
    });
  }

  static const _currentStatusId = 1;
}
