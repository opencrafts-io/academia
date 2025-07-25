import 'package:dartz/dartz.dart';
import '../domain.dart';
import 'package:academia/core/core.dart';
//
class GetSpecificAttendee{
  final ShereheRepository repository;

  GetSpecificAttendee(this.repository);

  Future<Either<Failure, Attendee>> execute() async {
    return repository.getSpecificAttendee(id as String);
  }

}