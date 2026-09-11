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
  SubscriptionRemoteDatasourceImpl({required this._apiClient});

  final ApiClient _apiClient;

  @override
  Future<Either<Failure, SubscriptionStatusDto>> getCurrentStatus() {
    return _apiClient.get(
      BillingApiPaths.subscription,
      decoder: (json) => SubscriptionStatusDto.fromJson(
        json as Map<String, dynamic>,
      ),
    );
  }
}
