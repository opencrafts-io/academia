import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/core.dart';
import 'package:drift/drift.dart';

abstract class InstitutionFeesLocalDatasource {
  Stream<Either<Failure, List<InstitutionFeeTransaction>>>
  watchFeesTransactionForInstitution({required int institutionID});

  Stream<Either<Failure, List<InstitutionFeeTransaction>>>
  watchAllFeesTransactions();

  Future<Either<Failure, void>> saveInstitutionFeeTransaction({
    required InstitutionFeeTransaction institutionFeeTransaction,
  });
}

class InstitutionFeesLocalDatasourceImpl
    implements InstitutionFeesLocalDatasource {
  final AppDataBase db;

  InstitutionFeesLocalDatasourceImpl(this.db);

  @override
  Stream<Either<Failure, List<InstitutionFeeTransaction>>>
  watchFeesTransactionForInstitution({required int institutionID}) {
    final query = db.select(db.institutionFeeTransactions)
      ..where((t) => t.institution.equals(institutionID))
      ..orderBy([
        (t) => OrderingTerm(expression: t.postingDate, mode: OrderingMode.desc),
      ]);

    return query.watch().map((rows) {
      try {
        return Right(rows);
      } catch (e) {
        return Left(CacheFailure(error: e, message: e.toString()));
      }
    });
  }

  @override
  Stream<Either<Failure, List<InstitutionFeeTransaction>>>
  watchAllFeesTransactions() {
    final query = db.select(db.institutionFeeTransactions)
      ..orderBy([
        (t) => OrderingTerm(expression: t.postingDate, mode: OrderingMode.desc),
      ]);

    return query.watch().map((rows) {
      try {
        return Right(rows);
      } catch (e) {
        return Left(CacheFailure(error: e, message: e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, void>> saveInstitutionFeeTransaction({
    required InstitutionFeeTransaction institutionFeeTransaction,
  }) async {
    try {
      await db
          .into(db.institutionFeeTransactions)
          .insertOnConflictUpdate(institutionFeeTransaction);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(error: e, message: e.toString()));
    }
  }
}
