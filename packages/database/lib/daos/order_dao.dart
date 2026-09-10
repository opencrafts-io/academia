import 'dart:convert';

import 'package:database/app_database_v2.dart';
import 'package:database/tables/tables.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

part 'order_dao.g.dart';

@injectable
@DriftAccessor(tables: [BillingOrders])
class OrderDao extends DatabaseAccessor<AppDatabaseV2> with _$OrderDaoMixin {
  OrderDao(super.db);

  Future<List<BillingOrder>> getOrders({
    String? status,
    int? page,
    int? pageSize,
  }) {
    final query = select(billingOrders)
      ..orderBy([(order) => OrderingTerm.desc(order.createdAt)]);

    if (status != null) {
      query.where((order) => order.status.equals(status));
    }
    if (page != null && pageSize != null) {
      final offset = page > 0 ? (page - 1) * pageSize : 0;
      query.limit(pageSize, offset: offset);
    }

    return query.get();
  }

  Future<BillingOrder?> getOrderById(String id) {
    return (select(billingOrders)..where((order) => order.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> upsertOrder(BillingOrdersCompanion order) async {
    await into(billingOrders).insertOnConflictUpdate(order);
  }

  static List<int> decodeMetadata(String value) {
    final decoded = jsonDecode(value);
    if (decoded is! List) return const [];
    return decoded.whereType<num>().map((item) => item.toInt()).toList();
  }

  static String encodeMetadata(List<int> metadata) => jsonEncode(metadata);
}
