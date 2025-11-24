import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetUserTicketsForEventUseCase {
  final ShereheRepository repository;

  GetUserTicketsForEventUseCase(this.repository);

  Future<Either<Failure, PaginatedResult<Attendee>>> call({
    required String eventId,
    required int page,
    required int limit,
  }) async {
    return repository.getUserTicketsForEvent(
      eventId: eventId,
      page: page,
      limit: limit,
    );
  }
}
