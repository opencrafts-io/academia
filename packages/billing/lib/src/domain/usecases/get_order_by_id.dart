import 'package:billing/src/domain/domain.dart' as domain;
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOrderById implements UseCase<domain.Order, String> {
  GetOrderById(this._repository);

  final domain.OrderRepository _repository;

  @override
  Future<Either<Failure, domain.Order>> call(String id) {
    return _repository.getOrderById(id);
  }
}
