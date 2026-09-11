import 'package:billing/src/data/data.dart';
import 'package:billing/src/domain/domain.dart' as domain;
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: domain.CheckoutRepository)
class CheckoutRepositoryImpl implements domain.CheckoutRepository {
  CheckoutRepositoryImpl({required this._remoteDataSource});

  final CheckoutRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, domain.CheckoutSession>> createCheckoutSession(
    domain.CreateCheckoutSessionRequest request,
  ) async {
    final result = await _remoteDataSource.createCheckoutSession(
      CreateCheckoutSessionDto(orderId: request.orderId),
    );
    return result.fold(Left.new, (dto) => Right(dto.toDomain(request.orderId)));
  }
}
