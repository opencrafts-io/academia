import 'package:academia/core/core.dart';
import 'package:academia/features/magnet/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:magnet/magnet.dart';

class FetchMagnetStudentTimetableUsecaseParams {
  final int institutionID;
  final String userID;
  MagnetPortalRepository magnetInstance;

  FetchMagnetStudentTimetableUsecaseParams({
    required this.magnetInstance,
    required this.institutionID,
    required this.userID,
  });
}

class FetchMagnetStudentTimetableUsecase
    extends
        UseCase<
          List<MagnetCourseInfo>,
          FetchMagnetStudentTimetableUsecaseParams
        > {
  final MagnetRepository magnetRepository;
  FetchMagnetStudentTimetableUsecase({required this.magnetRepository});
  @override
  Future<Either<Failure, List<MagnetCourseInfo>>> call(
    FetchMagnetStudentTimetableUsecaseParams params,
  ) async {
    return await magnetRepository.fetchStudentTimetable(
      params.magnetInstance,
      institutionID: params.institutionID,
      userID: params.userID,
    );
  }
}
