import 'package:billing/src/domain/domain.dart' as domain;
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetEntitlementsByPlanCode
    implements UseCase<List<domain.Entitlement>, String> {
  GetEntitlementsByPlanCode(this._repository);

  final domain.EntitlementRepository _repository;

  @override
  Future<Either<Failure, List<domain.Entitlement>>> call(String planCode) {
    return _repository.getByPlanCode(planCode);
  }
}
