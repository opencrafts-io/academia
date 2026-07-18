import 'package:academia/core/error/failures.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class InstitutionLocalDatasource {
  final AppDataBase localDB;

  InstitutionLocalDatasource({required this.localDB});

  Future<Either<Failure, Institution>> createOrUpdateInstitutionDetails(
    Institution institutionData,
  ) async {
    try {
      final created = await localDB
          .into(localDB.institutions)
          .insertReturning(
            institutionData,
            onConflict: DoUpdate((ins) => institutionData),
          );
      return right(created);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              "Failed to cache your institution details"
              "A quick restart or checking your storage might fix this",
        ),
      );
    }
  }

  Future<Either<Failure, List<Institution>>> getCachedInstitutions() async {
    try {
      final retrieved = await localDB.select(localDB.institutions).get();
      return right(retrieved);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              "Failed to retrieve your institution details."
              " A quick restart or checking your storage might fix this",
        ),
      );
    }
  }

  Future<Either<Failure, void>> deleteInstitutionDetails(
    int institutionID,
  ) async {
    try {
      await (localDB.delete(
        localDB.institutions,
      )..where((ins) => ins.institutionId.equals(institutionID))).go();
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              "Failed to delete institution details from cache"
              "A quick restart or checking your storage might fix this",
        ),
      );
    }
  }
}
