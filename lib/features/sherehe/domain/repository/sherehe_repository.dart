import 'dart:io';
import 'package:academia/features/sherehe/data/models/purchase_ticket_result_model.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/core.dart';

abstract class ShereheRepository {
  Future<Either<Failure, PaginatedEvents>> getAllEvents({
    required int page,
    required int limit,
  });

  Future<Either<Failure, Event>> getEventById({required String eventId});

  Future<Either<Failure, List<Event>>> getEventByOrganizerId({
    required String organizerId,
  });

  Future<Either<Failure, Event>> createEvent({
    required String eventName,
    required String eventDescription,
    String? eventUrl,
    required String eventLocation,
    required String eventDate,
    required String organizerId,
    required List<String> eventGenre,
    File? eventCardImage,
    File? eventPosterImage,
    File? eventBannerImage,
    required List<Ticket> tickets,
    PaymentTypes? selectedPaymentType,
    String? paybillNumber,
    String? accountReference,
    String? tillNumber,
    String? sendMoneyPhoneNumber,
  });

  Future<Either<Failure, PaginatedResult<Attendee>>> getAttendeesByEventId({
    required String eventId,
    required int page,
    required int limit,
  });

  Future<Either<Failure, Attendee>> getAttendeeByID(String id);

  Future<Either<Failure, List<Ticket>>> getTicketByEventId(String eventId);

  Future<Either<Failure, PurchaseTicketResult>> purchaseTicket({
    required String ticketId,
    required int ticketQuantity,
    required String? phoneNumber,
  });

  Future<Either<Failure, String>> confirmPayment({
    required String transId,
  });

  Future<Either<Failure, PaginatedResult<Attendee>>>
  getUserPurchasedTicketsForEvent({
    required String eventId,
    required int page,
    required int limit,
  });

  Future<Either<Failure, PaginatedResult<Attendee>>>
  getAllUserPurchasedTickets({required int page, required int limit});

  Future<Either<Failure, List<Attendee>>> searchUserAttendedEvents({
    required String query,
  });

  Future<Either<Failure, String>> validateAttendee({
    required String eventId,
    required String attendeeId,
  });

  Future<Either<Failure, List<Event>>> searchEvents({
    required String query,
  });
}
