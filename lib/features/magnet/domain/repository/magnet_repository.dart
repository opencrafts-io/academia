import 'package:academia/core/core.dart';
import 'package:academia/features/magnet/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:magnet/magnet.dart';

abstract class MagnetRepository {
  Future<Either<Failure, MagnetCredential>> getCachedMagnetCredential({
    required int institutionID,
    required String userID,
  });
  Future<Either<Failure, MagnetStudentProfile>> fetchStudentProfile(
    MagnetPortalRepository magnetPortalRepositoryInstance, {
    required int institutionID,
    required String userID,
  });
  Future<Either<Failure, MagnetStudentProfile>> getCachedMagnetStudentProfile({
    required int institutionID,
    required String userID,
  });

  Future<Either<Failure, List<MagnetCourseInfo>>> fetchStudentTimetable(
    MagnetPortalRepository magnetPortalRepositoryInstance, {
    required int institutionID,
    required String userID,
  });

  Future<Either<Failure, List<MagnetCourseInfo>>>
  getCachedMagnetStudentTimetable({
    required int institutionID,
    required String userID,
  });

  Future<Either<Failure, MagnetCourseInfo>> deleteCachedMagnetCourse({
    required String courseCode,
    required int institutionID,
    required String userID,
  });

  Future<Either<Failure, bool>> login(
    MagnetPortalRepository magnetPortalRepositoryInstance,
    Credentials creds, {
    required int institutionID,
    required String userID,
  });

  Future<Either<MagnetFailure, bool>> dropCourse(
    MagnetPortalRepository magnetPortalRepositoryInstance,
    String courseId, {
    required int institutionID,
    required String userID,
  });
  Future<Either<Failure, List<MagnetFinancialTransaction>>>
  fetchStudentFeeStatements(
    MagnetPortalRepository magnetPortalRepositoryInstance, {
    required int institutionID,
    required String userID,
  });

  Future<Either<MagnetFailure, bool>> resetPassword(
    MagnetPortalRepository magnetPortalRepositoryInstance, {
    String? newPassword,
    required int institutionID,
    required String userID,
  });
  Future<Either<MagnetFailure, bool>> updateStudentSchedule(
    MagnetPortalRepository magnetPortalRepositoryInstance,
    CourseInfo courseUpdate, {
    required int institutionID,
    required String userID,
  });

  Future<Either<MagnetFailure, bool>> updateStudentProfile(
    MagnetPortalRepository magnetPortalRepositoryInstance,
    StudentProfile updatedProfile, {
    required int institutionID,
    required String userID,
  });

  Future<Either<Failure, bool>> isLoggedIn(
    MagnetPortalRepository magnetPortalRepositoryInstance, {
    required int institutionID,
    required String userID,
  });
  Future<Either<MagnetFailure, bool>> logout(
    MagnetPortalRepository magnetPortalRepositoryInstance, {
    required int institutionID,
    required String userID,
  });
}
