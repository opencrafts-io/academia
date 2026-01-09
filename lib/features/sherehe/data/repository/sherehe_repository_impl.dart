import 'package:academia/features/sherehe/data/data.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/core.dart';
import 'dart:io';

class ShereheRepositoryImpl implements ShereheRepository {
  final ShereheRemoteDataSource remoteDataSource;
  final ShereheLocalDataSource localDataSource;

  ShereheRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, PaginatedEvents>> getAllEvents({
    required int page,
    required int limit,
  }) async {
    final result = await remoteDataSource.getAllEvents(
      page: page,
      limit: limit,
    );
    return result.fold((failure) => Left(failure), (paginatedData) async {
      return Right(
        PaginatedEvents(
          events: paginatedData.events.map((e) => e.toEntity()).toList(),
          nextPage: paginatedData.nextPage,
          previousPage: paginatedData.previousPage,
          totalEvents: paginatedData.totalEvents,
        ),
      );
    });
  }

  @override
  Future<Either<Failure, Event>> getEventById({required String eventId}) async {
    final result = await remoteDataSource.getEventById(eventId: eventId);
    return result.fold(
      (failure) => left(failure),
      (event) => right(event.toEntity()),
    );
  }

  @override
  Future<Either<Failure, List<Event>>> getEventByOrganizerId({
    required String organizerId,
  }) async {
    final result = await remoteDataSource.getEventByOrganizerId(
      organizerId: organizerId,
    );
    return result.fold(
      (failure) => left(failure),
      (events) => right(events.map((e) => e.toEntity()).toList()),
    );
  }

  @override
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
  }) async {
    final result = await remoteDataSource.createEvent(
      eventName: eventName,
      eventDescription: eventDescription,
      eventLocation: eventLocation,
      eventDate: eventDate,
      organizerId: organizerId,
      eventGenre: eventGenre,
      eventCardImage: eventCardImage,
      eventPosterImage: eventPosterImage,
      eventBannerImage: eventBannerImage,
      tickets: tickets.map((ticket) => ticket.toModel()).toList(),
      selectedPaymentType: selectedPaymentType,
      paybillNumber: paybillNumber,
      accountReference: accountReference,
      tillNumber: tillNumber,
      sendMoneyPhoneNumber: sendMoneyPhoneNumber,
    );
    return result.fold(
      (failure) => left(failure),
      (createdEvent) => right(createdEvent.toEntity()),
    );
  }

  @override
  Future<Either<Failure, PaginatedResult<Attendee>>> getAttendeesByEventId({
    required String eventId,
    required int page,
    required int limit,
  }) async {
    final result = await remoteDataSource.getAttendeesByEventId(
      eventId: eventId,
      page: page,
      limit: limit,
    );
    return result.fold(
      (failure) => left(failure),
      (paginatedData) => right(
        PaginatedResult(
          results: paginatedData.results.map((e) => e.toEntity()).toList(),
          next: paginatedData.next,
          previous: paginatedData.previous,
          currentPage: paginatedData.currentPage,
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, Attendee>> getAttendeeByID(String id) async {
    final result = await remoteDataSource.getAttendeeByID(id);
    return result.fold(
      (failure) => left(failure),
      (attendee) => right(attendee.toEntity()),
    );
  }

  @override
  Future<Either<Failure, List<Ticket>>> getTicketByEventId(
    String eventId,
  ) async {
    final result = await remoteDataSource.getTicketByEventId(eventId);
    return result.fold(
      (failure) => left(failure),
      (tickets) => right(tickets.map((ticket) => ticket.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, Attendee>> purchaseTicket({
    required String ticketId,
    required int ticketQuantity,
  }) async {
    final result = await remoteDataSource.purchaseTicket(
      ticketId: ticketId,
      ticketQuantity: ticketQuantity,
    );
    return result.fold(
      (failure) => left(failure),
      (attendee) => right(attendee.toEntity()),
    );
  }

  @override
  Future<Either<Failure, PaginatedResult<Attendee>>>
  getUserPurchasedTicketsForEvent({
    required String eventId,
    required int page,
    required int limit,
  }) async {
    final result = await remoteDataSource.getUserPurchasedTicketsForEvent(
      eventId: eventId,
      page: page,
      limit: limit,
    );
    return result.fold(
      (failure) => left(failure),
      (paginatedData) => right(
        PaginatedResult(
          results: paginatedData.results.map((e) => e.toEntity()).toList(),
          next: paginatedData.next,
          previous: paginatedData.previous,
          currentPage: paginatedData.currentPage,
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, PaginatedResult<Attendee>>>
  getAllUserPurchasedTickets({required int page, required int limit}) async {
    final result = await remoteDataSource.getAllUserPurchasedTickets(
      page: page,
      limit: limit,
    );
    return result.fold(
      (failure) => left(failure),
      (paginatedData) => right(
        PaginatedResult(
          results: paginatedData.results.map((e) => e.toEntity()).toList(),
          next: paginatedData.next,
          previous: paginatedData.previous,
          currentPage: paginatedData.currentPage,
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, List<Attendee>>> searchUserAttendedEvents({
    required String query,
  }) async {
    final result = await remoteDataSource.searchUserAttendedEvents(
      query: query,
    );
    return result.fold(
      (failure) => left(failure),
      (attendees) => right(attendees.map((e) => e.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, String>> validateAttendee({
    required String eventId,
    required String attendeeId,
  }) async {
    final result = await remoteDataSource.validateAttendee(
      eventId: eventId,
      attendeeId: attendeeId,
    );
    return result.fold((failure) => left(failure), (message) => right(message));
  }

  @override
  Future<Either<Failure, List<Event>>> searchEvents({
    required String query,
  }) async {
    final result = await remoteDataSource.searchEvents(query: query);
    return result.fold(
      (failure) => left(failure),
      (events) => right(events.map((e) => e.toEntity()).toList()),
    );
  }
}
