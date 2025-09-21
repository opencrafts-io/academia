import 'package:academia/core/core.dart';
import 'package:academia/features/magnet/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:magnet/magnet.dart';

class FetchMagnetFinancialFeesStatementsUsecaseParams {
  final int institutionID;
  final String userID;
  final MagnetPortalRepository magnetPortalRepository;
  FetchMagnetFinancialFeesStatementsUsecaseParams({
    required this.institutionID,
    required this.userID,
    required this.magnetPortalRepository,
  });
}

class FetchMagnetFinancialFeesStatementsUsecase
    extends
        UseCase<
          List<MagnetFinancialTransaction>,
          FetchMagnetFinancialFeesStatementsUsecaseParams
        > {
  final MagnetRepository magnetRepository;
  FetchMagnetFinancialFeesStatementsUsecase({required this.magnetRepository});
  @override
  Future<Either<Failure, List<MagnetFinancialTransaction>>> call(
    FetchMagnetFinancialFeesStatementsUsecaseParams params,
  ) async {
    return await magnetRepository.fetchStudentFeeStatements(
      params.magnetPortalRepository,
      institutionID: params.institutionID,
      userID: params.userID,
    );
  }
}
