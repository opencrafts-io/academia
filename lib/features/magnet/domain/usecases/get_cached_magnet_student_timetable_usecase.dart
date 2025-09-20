import 'package:academia/core/core.dart';
import 'package:academia/features/magnet/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetCachedMagnetStudentTimetableUsecaseParams {
  final int institutionID;
  final String userID;

  GetCachedMagnetStudentTimetableUsecaseParams({
    required this.userID,
    required this.institutionID,
  });
}

class GetCachedMagnetStudentTimetableUsecase
    extends
        UseCase<
          List<MagnetCourseInfo>,
          GetCachedMagnetStudentTimetableUsecaseParams
        > {
  final MagnetRepository magnetRepository;

  GetCachedMagnetStudentTimetableUsecase({required this.magnetRepository});
  @override
  Future<Either<Failure, List<MagnetCourseInfo>>> call(
    GetCachedMagnetStudentTimetableUsecaseParams params,
  ) async {
    return await magnetRepository.getCachedMagnetStudentTimetable(
      institutionID: params.institutionID,
      userID: params.userID,
    );
  }
}
