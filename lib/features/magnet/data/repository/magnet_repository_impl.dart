import 'package:academia/core/error/failures.dart';
import 'package:academia/features/magnet/data/models/magnet_credential_extension.dart';
import 'package:academia/features/magnet/magnet.dart';
import 'package:dartz/dartz.dart';
import 'package:magnet/magnet.dart';

class MagnetRepositoryImpl implements MagnetRepository {
  MagnetCredentialsLocalDatasource magnetCredentialsLocalDatasource;
  MagnetStudentProfileLocalDatasource magnetStudentProfileLocalDatasource;

  MagnetRepositoryImpl({
    required this.magnetStudentProfileLocalDatasource,
    required this.magnetCredentialsLocalDatasource,
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
  Future<Either<MagnetFailure, List<CourseInfo>>> fetchStudentTimetable(
    MagnetPortalRepository magnetPortalRepositoryInstance, {
    required int institutionID,
    required String userID,
  }) {
    return magnetPortalRepositoryInstance.fetchStudentTimetable();
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
  Future<Either<MagnetFailure, bool>> isLoggedIn(
    MagnetPortalRepository magnetPortalRepositoryInstance, {
    required int institutionID,
    required String userID,
  }) {
    return magnetPortalRepositoryInstance.isLoggedIn();
  }

  @override
  Future<Either<MagnetFailure, StudentProfile>> fetchStudentProfile(
    MagnetPortalRepository magnetPortalRepositoryInstance, {
    required int institutionID,
    required String userID,
  }) {
    return magnetPortalRepositoryInstance.fetchStudentProfile();
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
