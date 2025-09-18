import 'package:academia/core/core.dart';
import 'package:academia/features/magnet/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:magnet/magnet.dart';

class FetchMagnetStudentProfileUsecaseParams {
  final MagnetPortalRepository magnetInstance;
  final int institutionID;
  final String userID;

  FetchMagnetStudentProfileUsecaseParams({
    required this.magnetInstance,
    required this.institutionID,
    required this.userID,
  });
}

class FetchMagnetStudentProfileUsecase
    extends
        UseCase<MagnetStudentProfile, FetchMagnetStudentProfileUsecaseParams> {
  final MagnetRepository magnetRepository;
  FetchMagnetStudentProfileUsecase({required this.magnetRepository});
  @override
  Future<Either<Failure, MagnetStudentProfile>> call(
    FetchMagnetStudentProfileUsecaseParams params,
  ) async {
    return await magnetRepository.fetchStudentProfile(
      params.magnetInstance,
      institutionID: params.institutionID,
      userID: params.userID,
    );
  }
}
