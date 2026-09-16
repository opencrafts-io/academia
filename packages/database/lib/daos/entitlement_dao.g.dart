// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entitlement_dao.dart';

// ignore_for_file: type=lint
mixin _$EntitlementDaoMixin on DatabaseAccessor<AppDatabaseV2> {
  $BillingEntitlementsTable get billingEntitlements =>
      attachedDatabase.billingEntitlements;
  EntitlementDaoManager get managers => EntitlementDaoManager(this);
}

class EntitlementDaoManager {
  final _$EntitlementDaoMixin _db;
  EntitlementDaoManager(this._db);
  $$BillingEntitlementsTableTableManager get billingEntitlements =>
      $$BillingEntitlementsTableTableManager(
        _db.attachedDatabase,
        _db.billingEntitlements,
      );
}
