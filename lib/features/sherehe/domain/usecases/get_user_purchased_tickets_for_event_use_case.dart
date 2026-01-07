import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetUserPurchasedTicketsForEventUseCase {
  final ShereheRepository repository;

  GetUserPurchasedTicketsForEventUseCase(this.repository);

  Future<Either<Failure, PaginatedResult<Attendee>>> call({
    required String eventId,
    required int page,
    required int limit,
  }) async {
    return repository.getUserPurchasedTicketsForEvent(
      eventId: eventId,
      page: page,
      limit: limit,
    );
  }
}
