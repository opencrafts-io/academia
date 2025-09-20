import 'package:academia/core/error/failures.dart';
import 'package:academia/features/magnet/data/models/magnet_credential_extension.dart';
import 'package:academia/features/magnet/magnet.dart';
import 'package:dartz/dartz.dart';
import 'package:magnet/magnet.dart';

class MagnetRepositoryImpl implements MagnetRepository {
  MagnetCredentialsLocalDatasource magnetCredentialsLocalDatasource;
  MagnetStudentProfileLocalDatasource magnetStudentProfileLocalDatasource;
  MagnetCourseLocalDataSource magnetCourseLocalDataSource;

  MagnetRepositoryImpl({
    required this.magnetStudentProfileLocalDatasource,
    required this.magnetCredentialsLocalDatasource,
    required this.magnetCourseLocalDataSource,
  });

  @override
  Future<Either<Failure, MagnetCredential>> getCachedMagnetCredential({
    required int institutionID,
    required String userID,
  }) async {
    final result = await magnetCredentialsLocalDatasource
        .getCachedMagnetCredentialByInstitutionID(institutionID);
    return result.fold(
      (error) => left(error),
      (cred) => right(cred.toEntity()),
    );
  }

  @override
  Future<Either<Failure, List<MagnetCourseInfo>>> fetchStudentTimetable(
    MagnetPortalRepository magnetPortalRepositoryInstance, {
    required int institutionID,
    required String userID,
  }) async {
    final result = await magnetPortalRepositoryInstance.fetchStudentTimetable();
    return await result.fold(
      (error) async =>
          left(NetworkFailure(message: error.message, error: error)),
      (magnetCourses) async {
        for (final course in magnetCourses) {
          await magnetCourseLocalDataSource.createOrUpdateMagnetCourseInfo(
            course.toData(userID: userID, institutionID: institutionID),
          );
        }

        return right(
          magnetCourses
              .map(
                (course) => course.toEntity(
                  userID: userID,
                  institutionID: institutionID,
                ),
              )
              .toList(),
        );
      },
    );
  }

  @override
  Future<Either<Failure, List<MagnetCourseInfo>>>
  getCachedMagnetStudentTimetable({
    required int institutionID,
    required String userID,
  }) async {
    final result = await magnetCourseLocalDataSource
        .getCachedMagnetCourseByInstitutionID(institutionID);
    return result.fold(
      (error) => left(error),
      (courses) => right(courses.map((course) => course.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, MagnetCourseInfo>> deleteCachedMagnetCourse({
    required String courseCode,
    required int institutionID,
    required String userID,
  }) async {
    final result = await magnetCourseLocalDataSource
        .deleteMagnetCourseByCourseCode(courseCode);
    return result.fold(
      (error) => left(error),
      (courses) =>
          right(courses.map((course) => course.toEntity()).toList().first),
    );
  }

  @override
  Future<Either<MagnetFailure, bool>> logout(
    MagnetPortalRepository magnetPortalRepositoryInstance, {
    required int institutionID,
    required String userID,
  }) {
    return magnetPortalRepositoryInstance.logout();
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn(
    MagnetPortalRepository magnetPortalRepositoryInstance, {
    required int institutionID,
    required String userID,
  }) async {
    final result = await magnetPortalRepositoryInstance.isLoggedIn();
    return result.fold(
      (error) => left(NetworkFailure(message: error.message, error: error)),
      (ok) => right(ok),
    );
  }

  @override
  Future<Either<Failure, MagnetStudentProfile>> fetchStudentProfile(
    MagnetPortalRepository magnetPortalRepositoryInstance, {
    required int institutionID,
    required String userID,
  }) async {
    final result = await magnetPortalRepositoryInstance.fetchStudentProfile();
    return await result.fold(
      (error) async =>
          left(NetworkFailure(message: error.message, error: error)),
      (profile) async {
        final cacheRes = await magnetStudentProfileLocalDatasource
            .createOrUpdateMagnetStudentProfile(
              profile.toData(userID: userID, institutionID: institutionID),
            );
        return cacheRes.fold(
          (error) => left(error),
          (profile) => right(profile.toEntity()),
        );
      },
    );
  }

  @override
  Future<Either<Failure, MagnetStudentProfile>> getCachedMagnetStudentProfile({
    required int institutionID,
    required String userID,
  }) async {
    final cacheRes = await magnetStudentProfileLocalDatasource
        .getCachedMagnetStudentProfileByInstitutionID(institutionID);
    return cacheRes.fold(
      (error) => left(error),
      (profile) => right(profile.toEntity()),
    );
  }

  @override
  Future<Either<Failure, bool>> login(
    MagnetPortalRepository magnetPortalRepositoryInstance,
    Credentials creds, {
    required int institutionID,
    required String userID,
  }) async {
    final result = await magnetPortalRepositoryInstance.login(creds);
    return result.fold(
      (error) => left(NetworkFailure(message: error.message, error: error)),
      (ok) async {
        if (ok) {
          final cacheRes = await magnetCredentialsLocalDatasource
              .createOrUpdateMagnetCredentials(
                creds.toData(userID: userID, institutionID: institutionID),
              );

          return cacheRes.fold((error) => left(error), (cred) => right(true));
        }
        return right(ok);
      },
    );
  }

  @override
  Future<Either<MagnetFailure, List<FinancialTransaction>>>
  fetchStudentFeeStatements(
    MagnetPortalRepository magnetPortalRepositoryInstance, {
    required int institutionID,
    required String userID,
  }) {
    return magnetPortalRepositoryInstance.fetchStudentFeeStatements();
  }

  @override
  Future<Either<MagnetFailure, bool>> dropCourse(
    MagnetPortalRepository magnetPortalRepositoryInstance,
    String courseId, {
    required int institutionID,
    required String userID,
  }) {
    return magnetPortalRepositoryInstance.dropCourse(courseId);
  }

  @override
  Future<Either<MagnetFailure, bool>> resetPassword(
    MagnetPortalRepository magnetPortalRepositoryInstance, {
    String? newPassword,

    required int institutionID,
    required String userID,
  }) {
    return magnetPortalRepositoryInstance.resetPassword(
      newPassword: newPassword,
    );
  }

  @override
  Future<Either<MagnetFailure, bool>> updateStudentSchedule(
    MagnetPortalRepository magnetPortalRepositoryInstance,
    CourseInfo courseUpdate, {
    required int institutionID,
    required String userID,
  }) {
    return magnetPortalRepositoryInstance.updateStudentSchedule(courseUpdate);
  }

  @override
  Future<Either<MagnetFailure, bool>> updateStudentProfile(
    MagnetPortalRepository magnetPortalRepositoryInstance,
    StudentProfile updatedProfile, {
    required int institutionID,
    required String userID,
  }) {
    return magnetPortalRepositoryInstance.updateStudentProfile(updatedProfile);
  }
}
