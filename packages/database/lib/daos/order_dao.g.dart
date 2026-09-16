// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_dao.dart';

// ignore_for_file: type=lint
mixin _$OrderDaoMixin on DatabaseAccessor<AppDatabaseV2> {
  $BillingOrdersTable get billingOrders => attachedDatabase.billingOrders;
  $BillingOrderItemsTable get billingOrderItems =>
      attachedDatabase.billingOrderItems;
  OrderDaoManager get managers => OrderDaoManager(this);
}

class OrderDaoManager {
  final _$OrderDaoMixin _db;
  OrderDaoManager(this._db);
  $$BillingOrdersTableTableManager get billingOrders =>
      $$BillingOrdersTableTableManager(_db.attachedDatabase, _db.billingOrders);
  $$BillingOrderItemsTableTableManager get billingOrderItems =>
      $$BillingOrderItemsTableTableManager(
        _db.attachedDatabase,
        _db.billingOrderItems,
      );
}
