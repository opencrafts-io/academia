import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

abstract class InstitutionCourseTimetableEntryLocalDatasource {
  // Watches all course timetable entries for an institution
  Stream<Either<Failure, List<InstitutionCourseTimetableEntryData>>>
  watchInstitutionCourseTimetableEntries(int institutionID);

  // Creates or updates an institution entry information
  Future<Either<Failure, void>> saveOrUpdateInstitutionCourseTimetableEntry(
    InstitutionCourseTimetableEntryData entry,
  );

  // Watches all
  Stream<Either<Failure, List<InstitutionCourseTimetableEntryData>>>
  watchAllInstitutionCourseTimetableEntries();
}

class InstitutionCourseTimetableEntryLocalDatasourceImpl
    implements InstitutionCourseTimetableEntryLocalDatasource {
  final AppDataBase localCache;

  InstitutionCourseTimetableEntryLocalDatasourceImpl({
    required this.localCache,
  });

  @override
  Stream<Either<Failure, List<InstitutionCourseTimetableEntryData>>>
  watchAllInstitutionCourseTimetableEntries() {
    return (localCache.select(localCache.institutionCourseTimetableEntry)
          ..orderBy([
            (entry) => OrderingTerm.asc(entry.dayOfWeek),
            (entry) => OrderingTerm.asc(entry.startTime),
          ]))
        .watch()
        .map<Either<Failure, List<InstitutionCourseTimetableEntryData>>>((
          entry,
        ) {
          return right(entry);
        })
        .handleError((error) {
          return Left(
            CacheFailure(
              message: "Couldn't retrieve timetable entries",
              error: error,
            ),
          );
        });
  }

  @override
  Future<Either<Failure, void>> saveOrUpdateInstitutionCourseTimetableEntry(
    InstitutionCourseTimetableEntryData entry,
  ) async {
    try {
      await localCache
          .into(localCache.institutionCourseTimetableEntry)
          .insertOnConflictUpdate(entry);

      return right(null);
    } catch (e) {
      return left(
        CacheFailure(message: "Failed to save timetable entry", error: e),
      );
    }
  }

  @override
  Stream<Either<Failure, List<InstitutionCourseTimetableEntryData>>>
  watchInstitutionCourseTimetableEntries(int institutionID) {
    return (localCache.select(localCache.institutionCourseTimetableEntry)
          ..where((entry) => entry.institution.equals(institutionID)))
        .watch()
        .map<Either<Failure, List<InstitutionCourseTimetableEntryData>>>((
          entry,
        ) {
          return right(entry);
        })
        .handleError((error) {
          return Left(
            CacheFailure(
              message: "Couldn't retrieve timetable entries",
              error: error,
            ),
          );
        });
  }
}
