import 'dart:async';

import 'package:billing/src/data/data.dart';
import 'package:billing/src/domain/domain.dart' as domain;
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: domain.OrderRepository)
class OrderRepositoryImpl implements domain.OrderRepository {
  OrderRepositoryImpl({
    required this._localDataSource,
    required this._remoteDataSource,
  });

  final OrderLocalDatasource _localDataSource;
  final OrderRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, domain.Order>> createOrder(
    domain.CreateOrderRequest request,
  ) async {
    final result = await _remoteDataSource.createOrder(request.toDto());
    return result.fold(Left.new, (dto) async {
      final order = dto.toDomain();
      unawaited(_localDataSource.cacheOrder(order));
      return Right(order);
    });
  }

  @override
  Future<Either<Failure, List<domain.Order>>> getOrders({
    String? status,
    int? page,
    int? pageSize,
  }) async {
    final remoteResult = await _remoteDataSource.getOrders(
      status: status,
      page: page,
      pageSize: pageSize,
    );

    return remoteResult.fold(
      (failure) => _localDataSource.getOrders(
        status: status,
        page: page,
        pageSize: pageSize,
      ),
      (dtos) async {
        unawaited(_cacheOrders(dtos));
        return Right(dtos.map((dto) => dto.toDomain()).toList());
      },
    );
  }

  @override
  Future<Either<Failure, domain.Order>> getOrderById(String id) async {
    final remoteResult = await _remoteDataSource.getOrderById(id);

    return remoteResult.fold((failure) => _localDataSource.getOrderById(id), (
      dto,
    ) async {
      unawaited(_localDataSource.cacheOrder(dto.toDomain()));
      return Right(dto.toDomain());
    });
  }

  @override
  Future<Either<Failure, List<domain.OrderItem>>> getOrderItems(
    String orderId,
  ) async {
    final remoteResult = await _remoteDataSource.getOrderItems(orderId);
    return remoteResult.fold(
      (failure) => _localDataSource.getOrderItems(orderId),
      (dtos) async {
        final items = dtos.map((dto) => dto.toDomain()).toList();
        unawaited(_cacheOrderItems(items));
        return Right(items);
      },
    );
  }

  @override
  Future<Either<Failure, domain.OrderItem>> createOrderItem(
    domain.CreateOrderItemRequest request,
  ) async {
    final result = await _remoteDataSource.createOrderItem(request.toDto());
    return result.fold(Left.new, (dto) async {
      final item = dto.toDomain();
      unawaited(_localDataSource.cacheOrderItem(item));
      return Right(item);
    });
  }

  Future<void> _cacheOrders(List<OrderDto> orders) async {
    for (final order in orders) {
      await _localDataSource.cacheOrder(order.toDomain());
    }
  }

  Future<void> _cacheOrderItems(List<domain.OrderItem> items) async {
    for (final item in items) {
      await _localDataSource.cacheOrderItem(item);
    }
  }
}
