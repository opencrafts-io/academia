import 'package:academia/core/core.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:dartz/dartz.dart';

class GetAllCachedInstitutionsUsecase
    extends UseCase<List<Institution>, String> {
  final InstitutionRepository institutionRepository;
  GetAllCachedInstitutionsUsecase({required this.institutionRepository});
  @override
  Future<Either<Failure, List<Institution>>> call(String accountID) {
    return institutionRepository.getAllUserAccountCachedInstitutions(accountID);
  }
}
