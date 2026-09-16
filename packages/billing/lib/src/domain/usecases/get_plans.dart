import 'package:billing/src/domain/domain.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

/// Fetches all plans.
@injectable
class GetPlans implements UseCase<List<Plan>, NoUseCaseParams> {
  GetPlans(this._planRepository);

  final PlanRepository _planRepository;

  @override
  Future<Either<Failure, List<Plan>>> call(NoUseCaseParams params) {
    return _planRepository.getPlans();
  }
}
