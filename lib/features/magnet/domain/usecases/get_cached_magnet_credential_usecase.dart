import 'package:academia/core/core.dart';
import 'package:academia/features/magnet/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetCachedMagnetCredentialUsecaseParams {
  final int institutionID;
  final String userID;

  GetCachedMagnetCredentialUsecaseParams({
    required this.institutionID,
    required this.userID,
  });
}

class GetCachedMagnetCredentialUsecase
    extends UseCase<MagnetCredential, GetCachedMagnetCredentialUsecaseParams> {
  final MagnetRepository magnetRepository;
  GetCachedMagnetCredentialUsecase({required this.magnetRepository});

  @override
  Future<Either<Failure, MagnetCredential>> call(
    GetCachedMagnetCredentialUsecaseParams params,
  ) {
    return magnetRepository.getCachedMagnetCredential(
      institutionID: params.institutionID,
      userID: params.userID,
    );
  }
}

