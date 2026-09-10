import 'package:billing/src/data/data.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract interface class OrderRemoteDataSource {
  Future<Either<Failure, List<OrderDto>>> getOrders({
    String? status,
    int? page,
    int? pageSize,
  });

  Future<Either<Failure, OrderDto>> getOrderById(String id);
}

@LazySingleton(as: OrderRemoteDataSource)
class OrderRemoteDatasourceImpl implements OrderRemoteDataSource {
  OrderRemoteDatasourceImpl({required this._apiClient});

  final ApiClient _apiClient;

  @override
  Future<Either<Failure, List<OrderDto>>> getOrders({
    String? status,
    int? page,
    int? pageSize,
  }) {
    return _apiClient.get(
      BillingApiPaths.orders,
      queryParameters: {
        if (status != null) 'status': status,
        if (page != null) 'page': page,
        if (pageSize != null) 'page_size': pageSize,
      },
      decoder: (json) => (json as List<dynamic>)
          .map((item) => OrderDto.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Future<Either<Failure, OrderDto>> getOrderById(String id) {
    return _apiClient.get(
      '${BillingApiPaths.orders}/$id',
      decoder: (json) => OrderDto.fromJson(json as Map<String, dynamic>),
    );
  }
}
