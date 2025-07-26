import 'package:dartz/dartz.dart';
import 'package:academia/core/core.dart';
import '../../domain/domain.dart';
import '../data.dart';

class ShereheRepositoryImpl implements ShereheRepository {
  final ShereheRemoteDataSource remoteDataSource;

  ShereheRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Event>>> getAllEvents() async {
    final result = await remoteDataSource.getAllEvents();
    return result.fold(
      (failure) => Left(failure),
      (models) => Right(models.map((e) => e.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, Event>> getSpecificEvent(String id) async {
    final result = await remoteDataSource.getSpecificEvent(id);
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model.toEntity()),
    );
  }

  @override
  Future<Either<Failure, List<Attendee>>> getAllAttendees() async {
    final result = await remoteDataSource.getAllAttendees();
    return result.fold(
      (failure) => Left(failure),
      (models) => Right(models.map((a) => a.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, Attendee>> getSpecificAttendee(String id) async {
    final result = await remoteDataSource.getSpecificAttendee(id);
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model.toEntity()),
    );
  }
}
