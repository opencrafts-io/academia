import 'package:billing/src/data/data.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract interface class EntitlementRemoteDataSource {
  Future<Either<Failure, List<EntitlementDto>>> getByPlanCode(
    String planCode,
  );
}

@LazySingleton(as: EntitlementRemoteDataSource)
class EntitlementRemoteDatasourceImpl implements EntitlementRemoteDataSource {
  EntitlementRemoteDatasourceImpl({
    required this._apiClient,
    required this._billingApiPaths,
  });

  final ApiClient _apiClient;
  final BillingApiPaths _billingApiPaths;

  @override
  Future<Either<Failure, List<EntitlementDto>>> getByPlanCode(
    String planCode,
  ) {
    return _apiClient.get(
      _billingApiPaths.entitlements(planCode),
      decoder: (json) => (json as List<dynamic>)
          .map((item) => EntitlementDto.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
