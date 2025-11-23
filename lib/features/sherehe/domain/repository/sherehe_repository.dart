import 'dart:io';
import '../domain.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/core.dart';

abstract class ShereheRepository {
  Future<Either<Failure, PaginatedEvents>> getAllEvents({
    required int page,
    required int limit,
  });

  Future<Either<Failure, Event>> getEventById({required String eventId});

  Future<Either<Failure, Event>> createEvent({
    required String eventName,
    required String eventDescription,
    String? eventUrl,
    required String eventLocation,
    required String eventDate,
    required String organizerId,
    required List<String> eventGenre,
    required File eventCardImage,
    required File eventPosterImage,
    required File eventBannerImage,
    required List<Ticket> tickets,
  });

  Future<Either<Failure, PaginatedResult<Attendee>>> getAttendeesByEventId({
    required String eventId,
    required int page,
    required int limit,
  });

  Future<Either<Failure, Attendee>> getAttendeeByID(String id);

  Future<Either<Failure, Attendee>> createAttendee({
    required String userId,
    required String eventId,
  });

  Future<Either<Failure, List<Ticket>>> getTicketByEventId(String eventId);

  Future<Either<Failure, Attendee>> purchaseTicket({
    required String ticketId,
    required int ticketQuantity,
  });
}
