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
  CheckoutRemoteDatasourceImpl({
    required this._apiClient,
    required this._billingApiPaths,
  });

  final ApiClient _apiClient;
  final BillingApiPaths _billingApiPaths;

  @override
  Future<Either<Failure, CheckoutSessionDto>> createCheckoutSession(
    CreateCheckoutSessionDto request,
  ) {
    return _apiClient.post(
      _billingApiPaths.checkoutSessions,
      data: request.toJson(),
      decoder: (json) =>
          CheckoutSessionDto.fromJson(json as Map<String, dynamic>),
    );
  }
}
