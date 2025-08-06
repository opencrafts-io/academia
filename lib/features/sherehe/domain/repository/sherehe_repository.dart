import 'dart:io';
import '../domain.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/core.dart';

abstract class ShereheRepository {
  Future<Either<Failure, List<Event>>> getAllEvents({
    required int page,
    required int limit,
  });
  Future<Either<Failure, Event>> getSpecificEvent(String id);
  Future<Either<Failure, List<Attendee>>> getAttendeesByEventId({
    required String eventId,
    required int page,
    required int limit,
  });
  Future<Either<Failure, Attendee>> getSpecificAttendee(String id);
  Future<Either<Failure, Unit>> createEvent(Event event, File imageFile);
  //TODO:Add ticketing on the next iteration//
}
