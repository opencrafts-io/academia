import 'package:academia/core/core.dart';
import 'package:academia/features/magnet/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetCachedMagnetStudentProfileUsecaseParams {
  final int institutionID;
  final String userID;

  GetCachedMagnetStudentProfileUsecaseParams({
    required this.institutionID,
    required this.userID,
  });
}

class GetCachedMagnetStudentProfileUsecase
    extends
        UseCase<
          MagnetStudentProfile,
          GetCachedMagnetStudentProfileUsecaseParams
        > {
  final MagnetRepository magnetRepository;
  GetCachedMagnetStudentProfileUsecase({required this.magnetRepository});
  @override
  Future<Either<Failure, MagnetStudentProfile>> call(
    GetCachedMagnetStudentProfileUsecaseParams params,
  ) async {
    return await magnetRepository.getCachedMagnetStudentProfile(
      institutionID: params.institutionID,
      userID: params.userID,
    );
  }
}
