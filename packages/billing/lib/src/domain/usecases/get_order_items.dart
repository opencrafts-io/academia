import 'package:billing/src/domain/domain.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOrderItems implements UseCase<List<OrderItem>, String> {
  GetOrderItems(this._repository);

  final OrderRepository _repository;

  @override
  Future<Either<Failure, List<OrderItem>>> call(String orderId) {
    return _repository.getOrderItems(orderId);
  }
}
