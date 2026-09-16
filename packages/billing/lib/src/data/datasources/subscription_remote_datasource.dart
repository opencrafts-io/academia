import 'package:billing/src/data/data.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract interface class SubscriptionRemoteDataSource {
  Future<Either<Failure, SubscriptionStatusDto>> getCurrentStatus();
}

@LazySingleton(as: SubscriptionRemoteDataSource)
class SubscriptionRemoteDatasourceImpl
    implements SubscriptionRemoteDataSource {
  SubscriptionRemoteDatasourceImpl({
    required this._apiClient,
    required this._billingApiPaths,
  });

  final ApiClient _apiClient;
  final BillingApiPaths _billingApiPaths;

  @override
  Future<Either<Failure, SubscriptionStatusDto>> getCurrentStatus() {
    return _apiClient.get(
      _billingApiPaths.subscription,
      decoder: (json) => SubscriptionStatusDto.fromJson(
        json as Map<String, dynamic>,
      ),
    );
  }
}
