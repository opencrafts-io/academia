import 'package:dartz/dartz.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/institution/institution.dart';

class WatchInstitutionFees
    extends
        StreamUseCase<Either<Failure, List<InstitutionFeeTransaction?>>, int> {
  final InstitutionFeesRepository repository;

  WatchInstitutionFees(this.repository);

  @override
  Stream<Either<Failure, List<InstitutionFeeTransaction?>>> call(
    int institutionID,
  ) {
    return repository.watchFeesTransactionForInstitution(
      institutionID: institutionID,
    );
  }
}

class WatchAllFees
    extends
        StreamUseCase<
          Either<Failure, List<InstitutionFeeTransaction?>>,
          NoParams
        > {
  final InstitutionFeesRepository repository;

  WatchAllFees(this.repository);

  @override
  Stream<Either<Failure, List<InstitutionFeeTransaction?>>> call(
    NoParams params,
  ) {
    return repository.watchAllFeesTransactions();
  }
}

class SaveFeeTransaction extends UseCase<void, InstitutionFeeTransaction> {
  final InstitutionFeesRepository repository;

  SaveFeeTransaction(this.repository);

  @override
  Future<Either<Failure, void>> call(
    InstitutionFeeTransaction transaction,
  ) async {
    return await repository.saveInstitutionFeeTransaction(
      institutionFeeTransaction: transaction,
    );
  }
}
