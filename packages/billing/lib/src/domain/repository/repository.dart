import 'package:billing/src/domain/domain.dart' as domain;
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

abstract class PlanRepository {
  Future<Either<Failure, domain.Plan>> getPlanByCode(String planCode);
  Future<Either<Failure, List<domain.Plan>>> getPlans({bool visible = true});
}

abstract class OrderRepository {
  Future<Either<Failure, List<domain.Order>>> getOrders({
    String? status,
    int? page,
    int? pageSize,
  });

  Future<Either<Failure, domain.Order>> getOrderById(String id);
}

abstract class SubscriptionRepository {
  Future<Either<Failure, domain.SubscriptionStatus>> getCurrentStatus();
}

abstract class EntitlementRepository {
  Future<Either<Failure, List<domain.Entitlement>>> getByPlanCode(
    String planCode,
  );
}
