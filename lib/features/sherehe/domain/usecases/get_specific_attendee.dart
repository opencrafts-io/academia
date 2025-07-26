import 'package:dartz/dartz.dart';
import '../domain.dart';
import 'package:academia/core/core.dart';
//
class GetSpecificAttendee{
  final ShereheRepository repository;

  GetSpecificAttendee(this.repository);

  Future<Either<Failure, Attendee>> execute(String attendeeId) async {
    return repository.getSpecificAttendee(attendeeId);
  }

}