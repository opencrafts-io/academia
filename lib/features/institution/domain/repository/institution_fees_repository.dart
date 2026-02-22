import 'package:dartz/dartz.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/institution/institution.dart';

abstract class InstitutionFeesRepository {
  /// Watches the fees transaction for an institution supplied by [institutionID]
  Stream<Either<Failure, List<InstitutionFeeTransaction?>>>
  watchFeesTransactionForInstitution({required int institutionID});

  /// Watches all fees transactions
  Stream<Either<Failure, List<InstitutionFeeTransaction?>>>
  watchAllFeesTransactions();

  /// Saves [institutionFeeTransaction] to local cache  and syncs it with
  /// remote server
  Future<Either<Failure, void>> saveInstitutionFeeTransaction({
    required InstitutionFeeTransaction institutionFeeTransaction,
  });
}
