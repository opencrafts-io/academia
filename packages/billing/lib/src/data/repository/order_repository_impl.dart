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

    return remoteResult.fold(
      (failure) => _localDataSource.getOrderById(id),
      (dto) async {
        unawaited(_localDataSource.cacheOrder(dto.toDomain()));
        return Right(dto.toDomain());
      },
    );
  }

  Future<void> _cacheOrders(List<OrderDto> orders) async {
    for (final order in orders) {
      await _localDataSource.cacheOrder(order.toDomain());
    }
  }
}
