import 'package:academia/core/core.dart';
import 'package:academia/features/magnet/domain/domain.dart';
import 'package:dartz/dartz.dart';

class DeleteMagentCourseByCourseCodeUsecaseParams {
  final String userID;
  final int institutionID;
  final String courseCode;

  DeleteMagentCourseByCourseCodeUsecaseParams({
    required this.userID,
    required this.courseCode,
    required this.institutionID,
  });
}

class DeleteMagentCourseByCourseCodeUsecase
    extends
        UseCase<MagnetCourseInfo, DeleteMagentCourseByCourseCodeUsecaseParams> {
  final MagnetRepository magnetRepository;
  DeleteMagentCourseByCourseCodeUsecase({required this.magnetRepository});
  @override
  Future<Either<Failure, MagnetCourseInfo>> call(
    DeleteMagentCourseByCourseCodeUsecaseParams params,
  ) async {
    return await magnetRepository.deleteCachedMagnetCourse(
      courseCode: params.courseCode,
      institutionID: params.institutionID,
      userID: params.userID,
    );
  }
}
