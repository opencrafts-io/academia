import 'package:billing/src/domain/domain.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

abstract class PlanRepository {
  Future<Either<Failure, Plan>> getPlanByCode(String planCode);
  Future<Either<Failure, List<Plan>>> getPlans();
}
