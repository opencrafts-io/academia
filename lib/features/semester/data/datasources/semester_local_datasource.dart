import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

abstract class SemesterLocalDatasource {
  /// Creates or updates a semester specified by [semester]
  Future<Either<Failure, Unit>> createOrUpdateSemester({
    required SemesterCompanion semester,
  });

  /// Returns a stream of all semesters
  Stream<Either<Failure, List<SemesterData>>> watchAllSemesters();

  /// Should return either a failure or a list of all semeters
  /// that are linked to a certain institution specified by [institutionId]
  Future<Either<Failure, List<SemesterData>>> getSemstersByInstitutionID({
    required int institutionId,
  });

  /// Deletes a semester from the local cache either returning a failure
  /// explaining what went wrong or nothing if everything was successful.
  Future<Either<Failure, Unit>> deleteSemesterByID({required int semesterId});

  Future<Either<Failure, SemesterData>> getSemesterById({
    required int semesterId,
  });
}

class SemesterLocalDatasourceImpl implements SemesterLocalDatasource {
  final AppDataBase appDataBase;

  SemesterLocalDatasourceImpl({required this.appDataBase});

  @override
  Stream<Either<Failure, List<SemesterData>>> watchAllSemesters() {
    return (appDataBase.select(appDataBase.semester)
          ..orderBy([(sem) => OrderingTerm.desc(sem.endDate)]))
        .watch()
        .map<Either<Failure, List<SemesterData>>>(
          (semesters) => right(semesters),
        )
        .handleError(
          (error) => left(
            CacheFailure(
              message: "We ran into an issue while retrieving semesters",
              error: error,
            ),
          ),
        );
  }

  @override
  Future<Either<Failure, List<SemesterData>>> getSemstersByInstitutionID({
    required int institutionId,
  }) async {
    try {
      final result = await (appDataBase.select(
        appDataBase.semester,
      )..orderBy([(sem) => OrderingTerm.desc(sem.endDate)])).get();
      return right(result);
    } catch (error) {
      return left(
        CacheFailure(
          message: "We ran into an issue while retrieving semesters",
          error: error,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteSemesterByID({
    required int semesterId,
  }) async {
    try {
      await (appDataBase.delete(
        appDataBase.semester,
      )..where((semester) => semester.id.equals(semesterId))).go();
      return right(unit);
    } catch (error) {
      return left(
        CacheFailure(
          message:
              "We ran into an issue while attempting to delete requested semester",
          error: error,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> createOrUpdateSemester({
    required SemesterCompanion semester,
  }) async {
    try {
      await (appDataBase.into(
        appDataBase.semester,
      )).insertOnConflictUpdate(semester);
      return right(unit);
    } catch (error) {
      return left(
        CacheFailure(
          message: "We ran into an issue while attempting to create semester",
          error: error,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, SemesterData>> getSemesterById({
    required int semesterId,
  }) async {
    try {
      final result = await (
        appDataBase.select(appDataBase.semester)
        ..where((sem)=> sem.id.equals(semesterId))
      ).getSingle();
      return right(result);
    } catch (error) {
      return left(
        CacheFailure(
          message: "We ran into an issue while retrieving semester",
          error: error,
        ),
      );
    }
  }
}
