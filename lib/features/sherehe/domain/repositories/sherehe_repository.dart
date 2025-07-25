import '../domain.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/core.dart';
abstract class ShereheRepository {
  Future<Either<Failure, List<Event>>> getAllEvents();
  Future<Either<Failure, Event>> getSpecificEvents(String id);
  Future<Either<Failure, List<Attendee>>> getAllAttendees();
  Future<Either<Failure, Attendee>> getSpecificAttendee(String id);
//TODO:Add ticketing on the next iteration
}