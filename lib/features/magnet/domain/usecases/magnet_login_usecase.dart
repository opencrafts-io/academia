import 'package:academia/core/core.dart';
import 'package:academia/features/magnet/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:magnet/magnet.dart';

class MagnetLoginUsecaseParams {
  Credentials credentials;
  MagnetPortalRepository magnetInstance;
  String userID;
  int institutionID;

  MagnetLoginUsecaseParams({
    required this.credentials,
    required this.magnetInstance,
    required this.institutionID,
    required this.userID,
  });
}

class MagnetLoginUsecase extends UseCase<bool, MagnetLoginUsecaseParams> {
  final MagnetRepository magnetRepository;
  MagnetLoginUsecase({required this.magnetRepository});
  @override
  Future<Either<Failure, bool>> call(MagnetLoginUsecaseParams params) async {
    final result = await magnetRepository.login(
      params.magnetInstance,
      params.credentials,
      institutionID: params.institutionID,
      userID: params.userID,
    );

    return result.fold(
      (magnetFailure) => left(
        MagnetInstanceFailure(
          error: magnetFailure.error ?? Object(),
          message: magnetFailure.message,
        ),
      ),
      (success) => right(success),
    );
  }
}
