import 'package:billing/src/domain/entities/entitlement.dart';
import 'package:billing/src/domain/repository/repository.dart';
import 'package:billing/src/domain/services/billing_service.dart';
import 'package:billing/src/domain/entities/subscription_status.dart';
import 'package:billing/src/domain/usecases/get_current_subscription_status.dart';
import 'package:billing/src/domain/usecases/get_entitlements_by_plan_code.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'fresh subscription verification does not fall back to cached status',
    () async {
      final repository = _SubscriptionRepository();
      final service = BillingService(
        getCurrentSubscriptionStatus: GetCurrentSubscriptionStatus(repository),
        getEntitlementsByPlanCode: GetEntitlementsByPlanCode(
          _EntitlementRepository(),
        ),
        accessPolicy: const DefaultSubscriptionAccessPolicy(),
        clock: _FixedClock(),
      );

      final result = await service.refreshSubscriptionStatus();

      expect(result.isLeft(), isTrue);
      expect(repository.freshReads, 1);
      expect(repository.cachedReads, 0);
    },
  );
}

class _SubscriptionRepository implements SubscriptionRepository {
  int cachedReads = 0;
  int freshReads = 0;

  @override
  Future<Either<Failure, SubscriptionStatus>> getCurrentStatus() async {
    cachedReads++;
    return right(const SubscriptionStatus(active: false, subscription: null));
  }

  @override
  Future<Either<Failure, SubscriptionStatus>> refreshCurrentStatus() async {
    freshReads++;
    return left(const Failure.network(message: 'offline'));
  }
}

class _EntitlementRepository implements EntitlementRepository {
  @override
  Future<Either<Failure, List<Entitlement>>> getByPlanCode(
    String planCode,
  ) async => right(const []);
}

class _FixedClock implements BillingClock {
  @override
  DateTime now() => DateTime.utc(2026, 10, 1);
}
