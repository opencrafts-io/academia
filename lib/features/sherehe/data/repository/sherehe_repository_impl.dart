import 'package:academia/features/sherehe/data/data.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
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
  Future<Either<Failure, Attendee>> createAttendee({
    required String userId,
    required String eventId,
  }) async {
    final result = await remoteDataSource.createAttendee(
      userId: userId,
      eventId: eventId,
    );
    return result.fold(
      (failure) => left(failure),
      (attendee) => right(attendee.toEntity()),
    );
  }
}
