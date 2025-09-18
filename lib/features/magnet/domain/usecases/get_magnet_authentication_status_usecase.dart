import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';
import 'package:magnet/magnet.dart';

class GetMagnetAuthenticationStatusUsecaseParams {
  final String userID;
  final int institutionID;
  final MagnetPortalRepository magnetPortalRepository;
  GetMagnetAuthenticationStatusUsecaseParams({
    required this.userID,
    required this.institutionID,
    required this.magnetPortalRepository,
  });
}

class GetMagnetAuthenticationStatusUsecase
    extends UseCase<bool, GetMagnetAuthenticationStatusUsecaseParams> {
  final MagnetRepository magnetRepository;
  GetMagnetAuthenticationStatusUsecase({required this.magnetRepository});
  @override
  Future<Either<Failure, bool>> call(
    GetMagnetAuthenticationStatusUsecaseParams params,
  ) async {
    return await magnetRepository.isLoggedIn(
      params.magnetPortalRepository,
      institutionID: params.institutionID,
      userID: params.userID,
    );
  }
}
