import 'package:billing/src/domain/domain.dart' as domain;
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateOrder implements UseCase<domain.Order, domain.CreateOrderRequest> {
  CreateOrder(this._repository);

  final domain.OrderRepository _repository;

  @override
  Future<Either<Failure, domain.Order>> call(domain.CreateOrderRequest params) {
    return _repository.createOrder(params);
  }
}
