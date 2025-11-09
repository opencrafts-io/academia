import 'dart:io';
import '../domain.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/core.dart';

abstract class ShereheRepository {
  Future<Either<Failure, List<Event>>> getCachedEvents();

  Future<Either<Failure, PaginatedEvents>> getAllEvents({
    required int page,
    required int limit,
  });

  Future<Either<Failure, Event>> getEventById({
    required String eventId,
  });

  Future<Either<Failure, List<Attendee>>> getAttendeesByEventId({
    required String eventId,
    required int page,
    required int limit,
  });
  
  Future<Either<Failure, Attendee>> getSpecificAttendee(String id);

  Future<Either<Failure, Event>> createEvent({
    required String eventName,
    required String eventDescription,
    String? eventUrl,
    required String eventLocation,
    required String eventDate,
    required String organizerId,
    required String eventGenre,
    required File eventCardImage,
    required File eventPosterImage,
    required File eventBannerImage,
    required List<Ticket> tickets,
  });

  Future<Either<Failure, Attendee>> createAttendee(Attendee attendee);
  //TODO:Add ticketing on the next iteration//
}
