import 'package:billing/src/domain/domain.dart';
import 'package:failure/failure.dart';

abstract class PlanRepository {
  Future<Either<Failure, Plan>> getPlanByCode(String planCode);
  Future<Either<Failure, List<Plan>>> listBillingPlans();
}
