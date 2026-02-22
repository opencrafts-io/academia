import 'package:dartz/dartz.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/institution/institution.dart';

class InstitutionFeesRepositoryImpl implements InstitutionFeesRepository {
  final InstitutionFeesLocalDatasource localDatasource;

  InstitutionFeesRepositoryImpl({required this.localDatasource});

  @override
  Stream<Either<Failure, List<InstitutionFeeTransaction>>>
  watchFeesTransactionForInstitution({required int institutionID}) {
    return localDatasource
        .watchFeesTransactionForInstitution(institutionID: institutionID)
        .map((either) {
          return either.fold(
            (failure) => Left(failure),
            (rows) => Right(rows.map((row) => row.toEntity()).toList()),
          );
        });
  }

  @override
  Stream<Either<Failure, List<InstitutionFeeTransaction>>>
  watchAllFeesTransactions() {
    return localDatasource.watchAllFeesTransactions().map((either) {
      return either.fold(
        (failure) => Left(failure),
        (rows) => Right(rows.map((row) => row.toEntity()).toList()),
      );
    });
  }

  @override
  Future<Either<Failure, void>> saveInstitutionFeeTransaction({
    required InstitutionFeeTransaction institutionFeeTransaction,
  }) async {
    return localDatasource.saveInstitutionFeeTransaction(
      institutionFeeTransaction: institutionFeeTransaction.toData(),
    );
  }
}

