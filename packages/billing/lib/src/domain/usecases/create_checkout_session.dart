import 'package:billing/src/domain/domain.dart' as domain;
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateCheckoutSession
    implements
        UseCase<domain.CheckoutSession, domain.CreateCheckoutSessionRequest> {
  CreateCheckoutSession(this._repository);

  final domain.CheckoutRepository _repository;

  @override
  Future<Either<Failure, domain.CheckoutSession>> call(
    domain.CreateCheckoutSessionRequest params,
  ) {
    return _repository.createCheckoutSession(params);
  }
}
