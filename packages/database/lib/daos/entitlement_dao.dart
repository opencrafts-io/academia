import 'package:database/app_database_v2.dart';
import 'package:database/tables/tables.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

part 'entitlement_dao.g.dart';

@injectable
@DriftAccessor(tables: [BillingEntitlements])
class EntitlementDao extends DatabaseAccessor<AppDatabaseV2>
    with _$EntitlementDaoMixin {
  EntitlementDao(super.db);

  Future<List<BillingEntitlement>> getByPlanCode(String planCode) {
    return (select(billingEntitlements)
          ..where((entitlement) => entitlement.planCode.equals(planCode)))
        .get();
  }

  Future<void> replaceForPlan(
    String planCode,
    List<BillingEntitlementsCompanion> entitlements,
  ) async {
    await transaction(() async {
      await (delete(billingEntitlements)
            ..where((entitlement) => entitlement.planCode.equals(planCode)))
          .go();
      await batch((batch) {
        batch.insertAll(billingEntitlements, entitlements);
      });
    });
  }
}
