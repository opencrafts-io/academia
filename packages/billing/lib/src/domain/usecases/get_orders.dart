import 'package:billing/src/domain/domain.dart' as domain;
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

class GetOrdersParams {
  const GetOrdersParams({this.status, this.page, this.pageSize});

  final String? status;
  final int? page;
  final int? pageSize;
}

@injectable
class GetOrders
    implements UseCase<List<domain.Order>, GetOrdersParams> {
  GetOrders(this._repository);

  final domain.OrderRepository _repository;

  @override
  Future<Either<Failure, List<domain.Order>>> call(GetOrdersParams params) {
    return _repository.getOrders(
      status: params.status,
      page: params.page,
      pageSize: params.pageSize,
    );
  }
}
