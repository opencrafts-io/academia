import 'package:dartz/dartz.dart';
import '../domain.dart';
import 'package:academia/core/core.dart';

class GetAttendee{
  final ShereheRepository repository;

  GetAttendee(this.repository);

  Future<Either<Failure, List<Attendee>>> execute() async {
    return repository.getAllAttendees();
  }

}