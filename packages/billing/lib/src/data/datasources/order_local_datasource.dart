import 'package:billing/src/data/data.dart';
import 'package:billing/src/domain/domain.dart' as domain;
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:database/database.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderLocalDatasource {
  OrderLocalDatasource({required this._orderDao});

  final OrderDao _orderDao;

  Future<Either<Failure, List<domain.OrderItem>>> getOrderItems(
    String orderId,
  ) async {
    try {
      final rows = await _orderDao.getOrderItems(orderId);
      return Right(rows.map((row) => row.toDomain()).toList());
    } catch (e, stackTrace) {
      return Left(
        Failure.cache(
          message: 'Failed to retrieve cached order items',
          error: e,
          stackTrace: stackTrace,
          code: 'ORDER_ITEMS_FETCH_CACHE_ERROR',
          metadata: {'order_id': orderId},
        ),
      );
    }
  }

  Future<Either<Failure, List<domain.Order>>> getOrders({
    String? status,
    int? page,
    int? pageSize,
  }) async {
    try {
      final rows = await _orderDao.getOrders(
        status: status,
        page: page,
        pageSize: pageSize,
      );
      return Right(rows.map((row) => row.toDomain()).toList());
    } catch (e, stackTrace) {
      return Left(
        Failure.cache(
          message: 'Failed to retrieve cached orders',
          error: e,
          stackTrace: stackTrace,
          code: 'ORDER_FETCH_CACHE_ERROR',
        ),
      );
    }
  }

  Future<Either<Failure, domain.Order>> getOrderById(String id) async {
    try {
      final row = await _orderDao.getOrderById(id);
      if (row == null) {
        return Left(
          Failure.cache(
            message: 'Order with ID $id not found in cache',
            code: 'ORDER_NOT_CACHED',
            metadata: {'order_id': id},
          ),
        );
      }
      return Right(row.toDomain());
    } catch (e, stackTrace) {
      return Left(
        Failure.cache(
          message: 'Failed to retrieve cached order $id',
          error: e,
          stackTrace: stackTrace,
          code: 'ORDER_FETCH_BY_ID_CACHE_ERROR',
          metadata: {'order_id': id},
        ),
      );
    }
  }

  Future<Either<Failure, Unit>> cacheOrder(domain.Order order) async {
    try {
      await _orderDao.upsertOrder(order.toDto().toCompanion());
      return const Right(unit);
    } catch (e, stackTrace) {
      return Left(
        Failure.cache(
          message: 'Failed to cache order ${order.id}',
          error: e,
          stackTrace: stackTrace,
          code: 'ORDER_CACHE_ERROR',
          metadata: {'order_id': order.id},
        ),
      );
    }
  }

  Future<Either<Failure, Unit>> cacheOrderItem(domain.OrderItem item) async {
    try {
      await _orderDao.upsertOrderItem(item.toCompanion());
      return const Right(unit);
    } catch (e, stackTrace) {
      return Left(
        Failure.cache(
          message: 'Failed to cache order item ${item.id}',
          error: e,
          stackTrace: stackTrace,
          code: 'ORDER_ITEM_CACHE_ERROR',
          metadata: {'order_id': item.orderId, 'item_id': item.id},
        ),
      );
    }
  }
}
