import 'package:academia/core/core.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:dartz/dartz.dart';

// class GetCachedProfileUsecase implements UseCase<UserProfile, NoParams> {
class AddAccountToInstitutionParams {
  final String accountID;
  final int institutionID;

  AddAccountToInstitutionParams({
    required this.accountID,
    required this.institutionID,
  });
}

class AddAccountToInstitution
    extends UseCase<bool, AddAccountToInstitutionParams> {
  final InstitutionRepository institutionRepository;
  AddAccountToInstitution({required this.institutionRepository});
  @override
  Future<Either<Failure, bool>> call(AddAccountToInstitutionParams params) {
    return institutionRepository.addAccountToInstitution(
      params.institutionID,
      params.accountID,
    );
  }
}
