import 'package:billing/src/domain/domain.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateOrderItem implements UseCase<OrderItem, CreateOrderItemRequest> {
  CreateOrderItem(this._repository);

  final OrderRepository _repository;

  @override
  Future<Either<Failure, OrderItem>> call(CreateOrderItemRequest params) {
    return _repository.createOrderItem(params);
  }
}
