import 'package:academia/features/magnet/magnet.dart';
import 'package:dartz/dartz.dart';
import 'package:magnet/magnet.dart';

class MagnetRepositoryImpl implements MagnetRepository {
  @override
  Future<Either<MagnetFailure, List<CourseInfo>>> fetchStudentTimetable(
    MagnetPortalRepository magnetPortalRepositoryInstance,
  ) {
    return magnetPortalRepositoryInstance.fetchStudentTimetable();
  }

  @override
  Future<Either<MagnetFailure, bool>> logout(
    MagnetPortalRepository magnetPortalRepositoryInstance,
  ) {
    return magnetPortalRepositoryInstance.logout();
  }

  @override
  Future<Either<MagnetFailure, bool>> isLoggedIn(
    MagnetPortalRepository magnetPortalRepositoryInstance,
  ) {
    return magnetPortalRepositoryInstance.isLoggedIn();
  }

  @override
  Future<Either<MagnetFailure, StudentProfile>> fetchStudentProfile(
    MagnetPortalRepository magnetPortalRepositoryInstance,
  ) {
    return magnetPortalRepositoryInstance.fetchStudentProfile();
  }

  @override
  Future<Either<MagnetFailure, bool>> login(
    MagnetPortalRepository magnetPortalRepositoryInstance,
    Credentials creds,
  ) {
    return magnetPortalRepositoryInstance.login(creds);
  }

  @override
  Future<Either<MagnetFailure, List<FinancialTransaction>>>
  fetchStudentFeeStatements(
    MagnetPortalRepository magnetPortalRepositoryInstance,
  ) {
    return magnetPortalRepositoryInstance.fetchStudentFeeStatements();
  }

  @override
  Future<Either<MagnetFailure, bool>> dropCourse(
    MagnetPortalRepository magnetPortalRepositoryInstance,
    String courseId,
  ) {
    return magnetPortalRepositoryInstance.dropCourse(courseId);
  }

  @override
  Future<Either<MagnetFailure, bool>> resetPassword(
    MagnetPortalRepository magnetPortalRepositoryInstance, {
    String? newPassword,
  }) {
    return magnetPortalRepositoryInstance.resetPassword(
      newPassword: newPassword,
    );
  }

  @override
  Future<Either<MagnetFailure, bool>> updateStudentSchedule(
    MagnetPortalRepository magnetPortalRepositoryInstance,
    CourseInfo courseUpdate,
  ) {
    return magnetPortalRepositoryInstance.updateStudentSchedule(courseUpdate);
  }

  @override
  Future<Either<MagnetFailure, bool>> updateStudentProfile(
    MagnetPortalRepository magnetPortalRepositoryInstance,
    StudentProfile updatedProfile,
  ) {
    return magnetPortalRepositoryInstance.updateStudentProfile(updatedProfile);
  }
}
