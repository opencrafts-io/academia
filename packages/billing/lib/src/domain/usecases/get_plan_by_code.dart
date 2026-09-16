import 'package:billing/src/domain/domain.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

/// Fetches a single plan by its [planCode].
@injectable
class GetPlanByCode implements UseCase<Plan, String> {
  GetPlanByCode(this._planRepository);

  final PlanRepository _planRepository;

  @override
  Future<Either<Failure, Plan>> call(String planCode) {
    return _planRepository.getPlanByCode(planCode);
  }
}
