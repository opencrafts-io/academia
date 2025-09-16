import 'package:academia/core/error/failures.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:dartz/dartz.dart';

abstract class InstitutionRepository {
  Future<Either<Failure, List<Institution>>> searchForInstitutionByName(
    String name,
  );
  Future<Either<Failure, bool>> addAccountToInstitution(
    int institutionID,
    String userID,
  );
  Future<Either<Failure, List<Institution>>> getAllUserAccountInstitutions(
    String userID,
  );
  Future<Either<Failure, List<Institution>>>
  getAllUserAccountCachedInstitutions(String userID);
}
