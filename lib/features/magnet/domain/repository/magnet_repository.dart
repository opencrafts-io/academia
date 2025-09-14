import 'package:dartz/dartz.dart';
import 'package:magnet/magnet.dart';

abstract class MagnetRepository {
  Future<Either<MagnetFailure, StudentProfile>> fetchStudentProfile(
    MagnetPortalRepository magnetPortalRepositoryInstance,
  );

  Future<Either<MagnetFailure, List<CourseInfo>>> fetchStudentTimetable(
    MagnetPortalRepository magnetPortalRepositoryInstance,
  );

  Future<Either<MagnetFailure, bool>> login(
    MagnetPortalRepository magnetPortalRepositoryInstance,
    Credentials creds,
  );

  Future<Either<MagnetFailure, bool>> dropCourse(
    MagnetPortalRepository magnetPortalRepositoryInstance,
    String courseId,
  );
  Future<Either<MagnetFailure, List<FinancialTransaction>>>
  fetchStudentFeeStatements(
    MagnetPortalRepository magnetPortalRepositoryInstance,
  );

  Future<Either<MagnetFailure, bool>> resetPassword(
    MagnetPortalRepository magnetPortalRepositoryInstance, {
    String? newPassword,
  });
  Future<Either<MagnetFailure, bool>> updateStudentSchedule(
    MagnetPortalRepository magnetPortalRepositoryInstance,
    CourseInfo courseUpdate,
  );

  Future<Either<MagnetFailure, bool>> updateStudentProfile(
    MagnetPortalRepository magnetPortalRepositoryInstance,
    StudentProfile updatedProfile,
  );

  Future<Either<MagnetFailure, bool>> isLoggedIn(
    MagnetPortalRepository magnetPortalRepositoryInstance,
  );
  Future<Either<MagnetFailure, bool>> logout(
    MagnetPortalRepository magnetPortalRepositoryInstance,
  );
}
