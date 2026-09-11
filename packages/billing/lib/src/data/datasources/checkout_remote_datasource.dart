import 'package:billing/src/data/data.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract interface class CheckoutRemoteDataSource {
  Future<Either<Failure, CheckoutSessionDto>> createCheckoutSession(
    CreateCheckoutSessionDto request,
  );
}

@LazySingleton(as: CheckoutRemoteDataSource)
class CheckoutRemoteDatasourceImpl implements CheckoutRemoteDataSource {
  CheckoutRemoteDatasourceImpl({required this._apiClient});

  final ApiClient _apiClient;

  @override
  Future<Either<Failure, CheckoutSessionDto>> createCheckoutSession(
    CreateCheckoutSessionDto request,
  ) {
    return _apiClient.post(
      BillingApiPaths.checkoutSessions,
      data: request.toJson(),
      decoder: (json) =>
          CheckoutSessionDto.fromJson(json as Map<String, dynamic>),
    );
  }
}
