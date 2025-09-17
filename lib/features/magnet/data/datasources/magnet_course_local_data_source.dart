import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class MagnetCourseLocalDataSource {
  final AppDataBase localDB;
  MagnetCourseLocalDataSource({required this.localDB});

  Future<Either<Failure, MagnetCourseInfoData>> createOrUpdateMagnetCourseInfo(
    MagnetCourseInfoData magnetCourseInfoData,
  ) async {
    try {
      final created = await localDB
          .into(localDB.magnetCourseInfo)
          .insertReturning(
            magnetCourseInfoData,
            onConflict: DoUpdate((ins) => magnetCourseInfoData),
          );
      return right(created);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              "Failed to cache course. "
              "A quick restart or checking your storage might fix this",
        ),
      );
    }
  }

  Future<Either<Failure, List<MagnetCourseInfoData>>>
  getCachedMagnetCourseByInstitutionID(int institutionID) async {
    try {
      final retrieved = await (localDB.select(
        localDB.magnetCourseInfo,
      )..where((course) => course.institutionID.equals(institutionID))).get();
      return right(retrieved);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              "Failed to retrieve cached courses. "
              "A quick restart or checking your storage might fix this",
        ),
      );
    }
  }

  Future<Either<Failure, List<MagnetCourseInfoData>>>
  deleteMagnetCourseByInstitutionID(int institutionID) async {
    try {
      final deleted =
          await (localDB.delete(localDB.magnetCourseInfo)
                ..where((course) => course.institutionID.equals(institutionID)))
              .goAndReturn();
      return right(deleted);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              "Failed to delete course from cache. "
              "A quick restart or checking your storage might fix this",
        ),
      );
    }
  }

  Future<Either<Failure, List<MagnetCourseInfoData>>>
  deleteMagnetCourseByCourseCode(String courseCode) async {
    try {
      final deleted = await (localDB.delete(
        localDB.magnetCourseInfo,
      )..where((course) => course.courseCode.equals(courseCode))).goAndReturn();
      return right(deleted);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              "Failed to delete course from cache. "
              "A quick restart or checking your storage might fix this",
        ),
      );
    }
  }
}
