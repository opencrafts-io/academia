import 'package:academia/core/core.dart';
import 'package:academia/features/timetable/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

// ================================================================
// Create or Update Timetable Use Case
// ================================================================

class CreateOrUpdateTimetable
    extends UseCase<TimetableEntity, CreateOrUpdateTimetableParams> {
  final TimetableRepository repository;

  CreateOrUpdateTimetable(this.repository);

  @override
  Future<Either<Failure, TimetableEntity>> call(
    CreateOrUpdateTimetableParams params,
  ) async {
    return await repository.createOrUpdateTimetable(
      timetable: params.timetable,
    );
  }
}

class CreateOrUpdateTimetableParams extends Equatable {
  final TimetableEntity timetable;

  const CreateOrUpdateTimetableParams({required this.timetable});

  @override
  List<Object?> get props => [timetable];
}

// ================================================================
// Get Timetable By ID Use Case
// ================================================================

class GetTimetableById
    extends UseCase<TimetableEntity, GetTimetableByIdParams> {
  final TimetableRepository repository;

  GetTimetableById(this.repository);

  @override
  Future<Either<Failure, TimetableEntity>> call(
    GetTimetableByIdParams params,
  ) async {
    return await repository.getTimetableById(id: params.id);
  }
}

class GetTimetableByIdParams extends Equatable {
  final String id;

  const GetTimetableByIdParams({required this.id});

  @override
  List<Object?> get props => [id];
}

// ================================================================
// Watch All Timetables Use Case
// ================================================================

class WatchAllTimetables
    extends StreamUseCase<Either<Failure, List<TimetableEntity>>, NoParams> {
  final TimetableRepository repository;

  WatchAllTimetables(this.repository);

  @override
  Stream<Either<Failure, List<TimetableEntity>>> call(NoParams params) {
    return repository.watchAllTimetables();
  }
}

// ================================================================
// Watch Timetables By User ID Use Case
// ================================================================

class WatchTimetablesByUserId
    extends
        StreamUseCase<
          Either<Failure, List<TimetableEntity>>,
          WatchTimetablesByUserIdParams
        > {
  final TimetableRepository repository;

  WatchTimetablesByUserId(this.repository);

  @override
  Stream<Either<Failure, List<TimetableEntity>>> call(
    WatchTimetablesByUserIdParams params,
  ) {
    return repository.watchTimetablesByUserId(userId: params.userId);
  }
}

class WatchTimetablesByUserIdParams extends Equatable {
  final String userId;

  const WatchTimetablesByUserIdParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}

// ================================================================
// Watch Timetables By Institution ID Use Case
// ================================================================

class WatchTimetablesByInstitutionId
    extends
        StreamUseCase<
          Either<Failure, List<TimetableEntity>>,
          WatchTimetablesByInstitutionIdParams
        > {
  final TimetableRepository repository;

  WatchTimetablesByInstitutionId(this.repository);

  @override
  Stream<Either<Failure, List<TimetableEntity>>> call(
    WatchTimetablesByInstitutionIdParams params,
  ) {
    return repository.watchTimetablesByInstitutionId(
      institutionId: params.institutionId,
    );
  }
}

class WatchTimetablesByInstitutionIdParams extends Equatable {
  final int institutionId;

  const WatchTimetablesByInstitutionIdParams({required this.institutionId});

  @override
  List<Object?> get props => [institutionId];
}

// ================================================================
// Delete Timetable Use Case
// ================================================================

class DeleteTimetable extends UseCase<Unit, DeleteTimetableParams> {
  final TimetableRepository repository;

  DeleteTimetable(this.repository);

  @override
  Future<Either<Failure, Unit>> call(DeleteTimetableParams params) async {
    return await repository.deleteTimetable(id: params.id);
  }
}

class DeleteTimetableParams extends Equatable {
  final String id;

  const DeleteTimetableParams({required this.id});

  @override
  List<Object?> get props => [id];
}

// ====================================================================
// Sync Timetables Use Case
// ====================================================================

class SyncTimetables extends UseCase<Unit, NoParams> {
  final TimetableRepository repository;

  SyncTimetables(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await repository.syncTimetables();
  }
}

// ====================================================================
// Fetch Timetables From Remote Use Case
// ====================================================================

class FetchTimetablesFromRemote
    extends UseCase<List<TimetableEntity>, NoParams> {
  final TimetableRepository repository;

  FetchTimetablesFromRemote(this.repository);

  @override
  Future<Either<Failure, List<TimetableEntity>>> call(NoParams params) async {
    return await repository.fetchTimetablesFromRemote();
  }
}
