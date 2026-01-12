import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/core.dart';

class GetAttendee {
  final ShereheRepository repository;

  GetAttendee(this.repository);

  Future<Either<Failure, PaginatedResult<Attendee>>> execute({
    required String eventId,
    required int page,
    required int limit,
  }) async {
    return repository.getAttendeesByEventId(
      eventId: eventId,
      page: page,
      limit: limit,
    );
  }
}
