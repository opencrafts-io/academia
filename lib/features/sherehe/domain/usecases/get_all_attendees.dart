import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/core.dart';

class GetAttendee {
  final ShereheRepository repository;

  GetAttendee(this.repository);

  Future<Either<Failure, List<Attendee>>> execute({
    required String eventId,
  }) async {
    return repository.getAttendeesByEventId(eventId: eventId);
  }
}
