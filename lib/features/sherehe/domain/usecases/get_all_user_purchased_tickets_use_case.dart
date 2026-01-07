import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetAllUserPurchasedTicketsUseCase {
  final ShereheRepository repository;

  GetAllUserPurchasedTicketsUseCase(this.repository);

  Future<Either<Failure, PaginatedResult<Attendee>>> call({
    required int page,
    required int limit,
  }) async {
    return repository.getAllUserPurchasedTickets(page: page, limit: limit);
  }
}
