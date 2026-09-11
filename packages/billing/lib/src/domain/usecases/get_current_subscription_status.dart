import 'package:billing/src/domain/domain.dart' as domain;
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCurrentSubscriptionStatus
    implements UseCase<domain.SubscriptionStatus, NoUseCaseParams> {
  GetCurrentSubscriptionStatus(this._repository);

  final domain.SubscriptionRepository _repository;

  @override
  Future<Either<Failure, domain.SubscriptionStatus>> call(
    NoUseCaseParams params,
  ) {
    return _repository.getCurrentStatus();
  }
}
