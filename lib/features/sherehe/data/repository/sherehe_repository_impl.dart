import 'package:dartz/dartz.dart';
import 'package:academia/core/core.dart';
import '../../domain/domain.dart';
import '../data.dart';
import 'dart:io';

class ShereheRepositoryImpl implements ShereheRepository {
  final ShereheRemoteDataSource remoteDataSource;
  final ShereheLocalDataSource localDataSource;

  ShereheRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Event>>> getCachedEvents() async {
    final cachedResult = await localDataSource.getCachedEvents();
    return cachedResult.fold(
      (failure) => left(failure),
      (cachedEvents) => right(cachedEvents.map((e) => e.toEntity()).toList()),
    );
  }

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
  Future<Either<Failure, List<Attendee>>> getAttendeesByEventId({
    required String eventId,
    required int page,
    required int limit,
  }) async {
    final remoteResult = await remoteDataSource.getAttendeesByEventId(
      eventId: eventId,
      page: page,
      limit: limit,
    );
    return remoteResult.fold((failure) => left(failure), (
      attendeeDataList,
    ) async {
      final cacheAttempt = await localDataSource.cacheAttendees(
        attendeeDataList,
      );
      cacheAttempt.fold(
        (cacheFailure) {
          print(
            "[WARNING] ShereheRepositoryImpl: Failed to cache attendees for event $eventId: $cacheFailure",
          );
        },
        (_) {
          print(
            "[INFO] ShereheRepositoryImpl: Successfully cached attendees for event $eventId.",
          );
        },
      );
      return right(attendeeDataList.map((a) => a.toEntity()).toList());
    });
  }

  @override
  Future<Either<Failure, Attendee>> getSpecificAttendee(String id) async {
    final remoteResult = await remoteDataSource.getSpecificAttendee(id);
    if (remoteResult.isLeft()) return left((remoteResult as Left).value);
    final attendeeModel = (remoteResult as Right).value;
    final cacheResult = await localDataSource.cacheAttendees([attendeeModel]);
    return cacheResult.fold(
      (failure) => left(failure),
      (_) => right(attendeeModel.toEntity()),
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
    required String eventGenre,
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
  Future<Either<Failure, Attendee>> createAttendee(Attendee attendee) async {
    final result = await remoteDataSource.createAttendee(attendee);
    return result.fold((failure) => left(failure), (attendeeModel) async {
      await localDataSource.cacheAttendees([attendeeModel]);
      return right(attendeeModel.toEntity());
    });
  }
}
