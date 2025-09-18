import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class MagnetCredentialsLocalDatasource {
  final AppDataBase localDB;
  MagnetCredentialsLocalDatasource({required this.localDB});

  Future<Either<Failure, MagnetCredential>>
  createOrUpdateMagnetCredentials(
    MagnetCredential magnetCredential,
  ) async {
    try {
      final created = await localDB
          .into(localDB.magnetCredentials)
          .insertReturning(
            magnetCredential,
            onConflict: DoUpdate((cred) => magnetCredential),
          );
      return right(created);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              "Failed to cache your school credentials. "
              "A quick restart or checking your storage might fix this",
        ),
      );
    }
  }

  Future<Either<Failure, MagnetCredential>>
  getCachedMagnetCredentialByInstitutionID(int institutionID) async {
    try {
      final retrieved =
          await (localDB.select(localDB.magnetCredentials)..where(
                (cred) => cred.institutionID.equals(institutionID),
              ))
              .getSingle();
      return right(retrieved);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              "Failed to retrieve your school credentials. "
              "Perhaps your're new here and might need to add them",
        ),
      );
    }
  }

  Future<Either<Failure, void>> deleteMagnetCredentialByInstitutionID(
    int institutionID,
  ) async {
    try {
      await (localDB.delete(
        localDB.magnetCredentials,
      )..where((cred) => cred.institutionID.equals(institutionID))).go();
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              "Failed to delete school profile details from cache. "
              "A quick restart or checking your storage might fix this",
        ),
      );
    }
  }
}
