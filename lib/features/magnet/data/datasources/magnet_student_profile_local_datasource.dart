import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class MagnetStudentProfileLocalDatasource {
  final AppDataBase localDB;
  MagnetStudentProfileLocalDatasource({required this.localDB});

  Future<Either<Failure, MagnetStudentProfileData>>
  createOrUpdateMagnetStudentProfile(
    MagnetStudentProfileData magnetStudentProfile,
  ) async {
    try {
      final created = await localDB
          .into(localDB.magnetStudentProfile)
          .insertReturning(
            magnetStudentProfile,
            onConflict: DoUpdate((ins) => magnetStudentProfile),
          );
      return right(created);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              "Failed to cache your school profile. "
              "A quick restart or checking your storage might fix this",
        ),
      );
    }
  }

  Future<Either<Failure, MagnetStudentProfileData>>
  getCachedMagnetStudentProfileByInstitutionID(int institutionID) async {
    try {
      final retrieved =
          await (localDB.select(localDB.magnetStudentProfile)
                ..where((profile) => profile.institutionID.equals(institutionID)))
              .getSingle();
      return right(retrieved);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              "Failed to retrieve your school profile. "
              " A quick restart or checking your storage might fix this",
        ),
      );
    }
  }

  Future<Either<Failure, void>> deleteMagnetProfileByInstitutionID(
    int institutionID,
  ) async {
    try {
      await (localDB.delete(
        localDB.magnetStudentProfile,
      )..where((profile) => profile.institutionID.equals(institutionID))).go();
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
