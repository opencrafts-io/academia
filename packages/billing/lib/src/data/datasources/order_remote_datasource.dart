import 'package:billing/src/data/data.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract interface class OrderRemoteDataSource {
  Future<Either<Failure, OrderDto>> createOrder(CreateOrderDto request);

  Future<Either<Failure, List<OrderDto>>> getOrders({
    String? status,
    int? page,
    int? pageSize,
  });

  Future<Either<Failure, OrderDto>> getOrderById(String id);

  Future<Either<Failure, List<OrderItemDto>>> getOrderItems(String orderId);

  Future<Either<Failure, OrderItemDto>> createOrderItem(
    CreateOrderItemDto request,
  );
}

@LazySingleton(as: OrderRemoteDataSource)
class OrderRemoteDatasourceImpl implements OrderRemoteDataSource {
  OrderRemoteDatasourceImpl({required this._apiClient});

  final ApiClient _apiClient;

  @override
  Future<Either<Failure, OrderDto>> createOrder(CreateOrderDto request) {
    return _apiClient.post(
      BillingApiPaths.orders,
      data: request.toJson(),
      decoder: (json) => OrderDto.fromJson(json as Map<String, dynamic>),
    );
  }

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

  @override
  Future<Either<Failure, List<OrderItemDto>>> getOrderItems(String orderId) {
    return _apiClient.get(
      BillingApiPaths.orderItems(orderId),
      decoder: (json) => (json as List<dynamic>)
          .map((item) => OrderItemDto.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Future<Either<Failure, OrderItemDto>> createOrderItem(
    CreateOrderItemDto request,
  ) {
    return _apiClient.post(
      BillingApiPaths.orderItems(request.orderId),
      data: request.toJson(),
      decoder: (json) => OrderItemDto.fromJson(json as Map<String, dynamic>),
    );
  }
}
