import 'package:billing/src/data/data.dart';
import 'package:billing/src/domain/domain.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:database/database.dart';
import 'package:injectable/injectable.dart';

@injectable
class EntitlementLocalDatasource {
  EntitlementLocalDatasource({required this._entitlementDao});

  final EntitlementDao _entitlementDao;

  Future<Either<Failure, List<Entitlement>>> getByPlanCode(
    String planCode,
  ) async {
    try {
      final rows = await _entitlementDao.getByPlanCode(planCode);
      if (rows.isEmpty) {
        return Left(
          Failure.cache(
            message: 'Entitlements for plan $planCode are not cached',
            code: 'ENTITLEMENTS_NOT_CACHED',
            metadata: {'plan_code': planCode},
          ),
        );
      }
      return Right(rows.map((row) => row.toDomain()).toList());
    } catch (e, stackTrace) {
      return Left(
        Failure.cache(
          message: 'Failed to retrieve cached entitlements',
          error: e,
          stackTrace: stackTrace,
          code: 'ENTITLEMENTS_FETCH_CACHE_ERROR',
          metadata: {'plan_code': planCode},
        ),
      );
    }
  }

  Future<Either<Failure, Unit>> cacheEntitlements(
    String planCode,
    List<Entitlement> entitlements,
  ) async {
    try {
      await _entitlementDao.replaceForPlan(
        planCode,
        entitlements.map((item) => item.toDto().toCompanion()).toList(),
      );
      return const Right(unit);
    } catch (e, stackTrace) {
      return Left(
        Failure.cache(
          message: 'Failed to cache entitlements for plan $planCode',
          error: e,
          stackTrace: stackTrace,
          code: 'ENTITLEMENTS_CACHE_ERROR',
          metadata: {'plan_code': planCode},
        ),
      );
    }
  }
}
