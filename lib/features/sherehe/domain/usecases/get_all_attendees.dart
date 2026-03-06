import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/core.dart';

class GetAllAttendees {
  final ShereheRepository repository;

  GetAllAttendees(this.repository);

  Future<Either<Failure, PaginatedResult<Attendee>>> call({
    required String eventId,
    required int page,
    required int limit,
  }) async {
    return repository.getAllAttendees(
      eventId: eventId,
      page: page,
      limit: limit,
    );
  }
}
