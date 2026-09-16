import 'dart:async';

import 'package:billing/src/data/data.dart';
import 'package:billing/src/domain/domain.dart' as domain;
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: domain.EntitlementRepository)
class EntitlementRepositoryImpl implements domain.EntitlementRepository {
  EntitlementRepositoryImpl({
    required this._localDataSource,
    required this._remoteDataSource,
  });

  final EntitlementLocalDatasource _localDataSource;
  final EntitlementRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<domain.Entitlement>>> getByPlanCode(
    String planCode,
  ) async {
    final remoteResult = await _remoteDataSource.getByPlanCode(planCode);

    return remoteResult.fold(
      (failure) => _localDataSource.getByPlanCode(planCode),
      (dtos) async {
        final entitlements = dtos.map((dto) => dto.toDomain()).toList();
        unawaited(_localDataSource.cacheEntitlements(planCode, entitlements));
        return Right(entitlements);
      },
    );
  }
}
