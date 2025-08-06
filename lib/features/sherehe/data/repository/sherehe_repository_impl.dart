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
  Future<Either<Failure, List<Event>>> getAllEvents({
    required int page,
    required int limit,
  }) async {
    // final remoteResult = await remoteDataSource.getAllEvents(
    //   page: page,
    //   limit: limit,
    // );

    // if (remoteResult.isLeft()) return left((remoteResult as Left).value);

    // final remoteEvents = (remoteResult as Right).value;

    // final cacheResult = await localDataSource.cacheEvents(remoteEvents);
    // return cacheResult.fold(
    //   (failure) => left(failure),
    //   (models) => right(models.map((e) => e.toEntity()).toList()),
    // );

    final result = await remoteDataSource.getAllEvents(
      page: page,
      limit: limit,
    );
    return result.fold(
          (failure) => Left(failure),
          (models) => Right(models.map((e) => e.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, Event>> getSpecificEvent(String id) async {
    // final remoteResult = await remoteDataSource.getSpecificEvent(id);

    // if (remoteResult.isLeft()) return left((remoteResult as Left).value);

    // final eventModel = (remoteResult as Right).value;

    // // Cache the event locally
    // final cacheResult = await localDataSource.cacheEvents([eventModel]);

    // return cacheResult.fold(
    //   (failure) => left(failure),
    //   (_) => right(eventModel.toEntity()),
    // );

    final result = await remoteDataSource.getSpecificEvent(id);
    return result.fold(
          (failure) => Left(failure),
          (model) => Right(model.toEntity()),
    );
  }

  @override
  Future<Either<Failure, List<Attendee>>> getAttendeesByEventId({
    required String eventId,
    required int page,
    required int limit,
  }) async {
    // final remoteResult = await remoteDataSource.getAttendeesByEventId(
    //   eventId: eventId,
    //   page: page,
    //   limit: limit,
    // );

    // if (remoteResult.isLeft()) return left((remoteResult as Left).value);

    // final attendees = (remoteResult as Right).value;

    // final cacheResult = await localDataSource.cacheAttendees(attendees);
    // return cacheResult.fold(
    //   (failure) => left(failure),
    //   (models) => right(models.map((a) => a.toEntity()).toList()),
    // );

    final result = await remoteDataSource.getAttendeesByEventId(
      eventId: eventId,
      page: page,
      limit: limit,
    );
    return result.fold(
          (failure) => Left(failure),
          (models) => Right(models.map((a) => a.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, Attendee>> getSpecificAttendee(String id) async {
    // final remoteResult = await remoteDataSource.getSpecificAttendee(id);

    // if (remoteResult.isLeft()) return left((remoteResult as Left).value);

    // final attendeeModel = (remoteResult as Right).value;

    // final cacheResult = await localDataSource.cacheAttendees([attendeeModel]);
    // return cacheResult.fold(
    //   (failure) => left(failure),
    //   (_) => right(attendeeModel.toEntity()),
    // );

    final result = await remoteDataSource.getSpecificAttendee(id);
    return result.fold(
          (failure) => Left(failure),
          (model) => Right(model.toEntity()),
    );
  }

  @override
  Future<Either<Failure, Unit>> createEvent(Event event, File imageFile) async {
    return await remoteDataSource.createEvent(event, eventImage: imageFile);
  }
}
