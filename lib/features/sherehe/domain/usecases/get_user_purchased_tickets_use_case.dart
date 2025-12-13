import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetUserPurchasedTicketsUseCase {
  final ShereheRepository repository;

  GetUserPurchasedTicketsUseCase(this.repository);

  Future<Either<Failure, PaginatedResult<Attendee>>> call({
    required int page,
    required int limit,
  }) async {
    return repository.getUserPurchasedTickets(page: page, limit: limit);
  }
}
