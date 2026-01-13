import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';

class ValidateAttendeeUseCase {
  final ShereheRepository repository;

  ValidateAttendeeUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required String eventId,
    required String attendeeId,
  }) {
    return repository.validateAttendee(
      eventId: eventId,
      attendeeId: attendeeId,
    );
  }
}
