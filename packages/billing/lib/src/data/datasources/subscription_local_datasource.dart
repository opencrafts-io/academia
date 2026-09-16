import 'package:billing/src/data/data.dart';
import 'package:billing/src/domain/domain.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:database/database.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubscriptionLocalDatasource {
  SubscriptionLocalDatasource({required this._subscriptionDao});

  final SubscriptionDao _subscriptionDao;

  Future<Either<Failure, SubscriptionStatus>> getCurrentStatus() async {
    try {
      final row = await _subscriptionDao.getCurrentStatus();
      if (row == null) {
        return const Left(
          Failure.cache(
            message: 'Subscription status is not cached',
            code: 'SUBSCRIPTION_STATUS_NOT_CACHED',
          ),
        );
      }
      return Right(await row.toDomain(_subscriptionDao));
    } catch (e, stackTrace) {
      return Left(
        Failure.cache(
          message: 'Failed to retrieve cached subscription status',
          error: e,
          stackTrace: stackTrace,
          code: 'SUBSCRIPTION_STATUS_CACHE_ERROR',
        ),
      );
    }
  }

  Future<Either<Failure, Unit>> cacheStatus(
    SubscriptionStatus status,
  ) async {
    try {
      final dto = status.toDto();
      await _subscriptionDao.cacheStatus(
        status: dto.toStatusCompanion(),
        subscription: dto.subscription?.toCompanion(),
      );
      return const Right(unit);
    } catch (e, stackTrace) {
      return Left(
        Failure.cache(
          message: 'Failed to cache subscription status',
          error: e,
          stackTrace: stackTrace,
          code: 'SUBSCRIPTION_STATUS_CACHE_WRITE_ERROR',
        ),
      );
    }
  }
}
