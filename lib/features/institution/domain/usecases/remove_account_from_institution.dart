import 'package:academia/core/core.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:dartz/dartz.dart';

class RemoveAccountFromInstitutionParams {
  final String accountID;
  final int institutionID;

  RemoveAccountFromInstitutionParams({
    required this.accountID,
    required this.institutionID,
  });
}

class RemoveAccountFromInstitutionUsecase
    extends UseCase<bool, RemoveAccountFromInstitutionParams> {
  final InstitutionRepository repository;

  RemoveAccountFromInstitutionUsecase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(
    RemoveAccountFromInstitutionParams params,
  ) async {
    return await repository.removeAccountFromInstitution(
      params.institutionID,
      params.accountID,
    );
  }
}
