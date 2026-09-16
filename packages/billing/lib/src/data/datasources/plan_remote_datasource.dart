import 'package:billing/src/data/data.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

/// Provides access to plan data over the network.
abstract interface class PlanRemoteDataSource {
  /// Fetches all plans.
  Future<Either<Failure, List<PlanDto>>> getPlans({bool visible = true});

  /// Fetches a single plan by its [code].
  Future<Either<Failure, PlanDto>> getPlan(String code);
}

@LazySingleton(as: PlanRemoteDataSource)
class PlanRemoteDatasourceImpl implements PlanRemoteDataSource {
  PlanRemoteDatasourceImpl({required this._apiClient});

  final ApiClient _apiClient;

  @override
  Future<Either<Failure, List<PlanDto>>> getPlans({bool visible = true}) {
    return _apiClient.get(
      BillingApiPaths.plans,
      queryParameters: {'visible': visible},
      decoder: (json) => (json as List<dynamic>)
          .map((e) => PlanDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Future<Either<Failure, PlanDto>> getPlan(String code) {
    return _apiClient.get(
      '${BillingApiPaths.plans}/$code',
      decoder: (json) => PlanDto.fromJson(json as Map<String, dynamic>),
    );
  }
}
