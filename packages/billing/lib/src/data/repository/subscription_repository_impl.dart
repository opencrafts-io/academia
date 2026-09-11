import 'dart:async';

import 'package:billing/src/data/data.dart';
import 'package:billing/src/domain/domain.dart' as domain;
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: domain.SubscriptionRepository)
class SubscriptionRepositoryImpl implements domain.SubscriptionRepository {
  SubscriptionRepositoryImpl({
    required this._localDataSource,
    required this._remoteDataSource,
  });

  final SubscriptionLocalDatasource _localDataSource;
  final SubscriptionRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, domain.SubscriptionStatus>> getCurrentStatus() async {
    final remoteResult = await _remoteDataSource.getCurrentStatus();

    return remoteResult.fold(
      (failure) => _localDataSource.getCurrentStatus(),
      (dto) async {
        final status = dto.toDomain();
        unawaited(_localDataSource.cacheStatus(status));
        return Right(status);
      },
    );
  }
}
