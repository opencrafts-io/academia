import 'package:academia/core/error/failures.dart';
import 'package:academia/features/institution/data/data.dart';
import 'package:academia/features/institution/domain/domain.dart';
import 'package:dartz/dartz.dart';

class InstitutionRepositoryImpl implements InstitutionRepository {
  final InstitutionRemoteDatasource institutionRemoteDatasource;
  final InstitutionLocalDatasource institutionLocalDatasource;

  InstitutionRepositoryImpl({
    required this.institutionRemoteDatasource,
    required this.institutionLocalDatasource,
  });

  @override
  Future<Either<Failure, bool>> addAccountToInstitution(
    int institutionID,
    String accountID,
  ) async {
    final result = await institutionRemoteDatasource.addAccountToInstitution(
      accountID,
      institutionID,
    );
    return result.fold((error) => left(error), (ok) {
      getAllUserAccountInstitutions(accountID);
      return right(ok);
    });
  }

  @override
  Future<Either<Failure, List<Institution>>>
  getAllUserAccountCachedInstitutions(String userID) async {
    final result = await institutionLocalDatasource.getCachedInstitutions();
    return result.fold((error) => left(error), (rawInstitutions) async {
      if (rawInstitutions.isEmpty) {
        return await getAllUserAccountInstitutions(userID);
      }
      return right(
        rawInstitutions
            .map((rawInstitution) => rawInstitution.toEntity())
            .toList(),
      );
    });
  }

  @override
  Future<Either<Failure, List<Institution>>> getAllUserAccountInstitutions(
    String accountID,
  ) async {
    final result = await institutionRemoteDatasource.getAccountInstitutions(
      accountID,
    );
    return result.fold((error) => left(error), (rawInstitutions) {
      for (final institution in rawInstitutions) {
        institutionLocalDatasource.createOrUpdateInstitutionDetails(
          institution,
        );
      }
      return right(
        rawInstitutions
            .map((rawInstitution) => rawInstitution.toEntity())
            .toList(),
      );
    });
  }

  @override
  Future<Either<Failure, List<Institution>>> searchForInstitutionByName(
    String name,
  ) async {
    final result = await institutionRemoteDatasource.searchForInstitutionByName(
      name,
    );

    return result.fold(
      (error) => left(error),
      (rawInstitutions) => right(
        rawInstitutions
            .map((rawInstitution) => rawInstitution.toEntity())
            .toList(),
      ),
    );
  }
}
