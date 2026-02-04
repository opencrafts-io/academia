import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/core.dart';
import 'package:drift/drift.dart';

abstract class InstitutionFeesLocalDatasource {
  Stream<Either<Failure, List<InstitutionFeeTransactionData>>>
  watchFeesTransactionForInstitution({required int institutionID});

  Stream<Either<Failure, List<InstitutionFeeTransactionData>>>
  watchAllFeesTransactions();

  Future<Either<Failure, void>> saveInstitutionFeeTransaction({
    required InstitutionFeeTransactionData institutionFeeTransaction,
  });
}

class InstitutionFeesLocalDatasourceImpl
    implements InstitutionFeesLocalDatasource {
  final AppDataBase db;

  InstitutionFeesLocalDatasourceImpl(this.db);

  @override
  Stream<Either<Failure, List<InstitutionFeeTransactionData>>>
  watchFeesTransactionForInstitution({required int institutionID}) {
    final query = db.select(db.institutionFeeTransaction)
      ..where((t) => t.institution.equals(institutionID))
      ..orderBy([
        (t) => OrderingTerm(expression: t.postingDate, mode: OrderingMode.desc),
        // (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc),
      ]);

    return query.watch().map((rows) {
      try {
        for (var row in rows) {
          // This will tell us if the milliseconds survived the database trip
          print(
            "DB Row: ${row.referenceNumber} | MS: ${row.postingDate?.millisecondsSinceEpoch}",
          );
        }
        return Right(rows);
      } catch (e) {
        return Left(CacheFailure(error: e, message: e.toString()));
      }
    });
  }

  @override
  Stream<Either<Failure, List<InstitutionFeeTransactionData>>>
  watchAllFeesTransactions() {
    final query = db.select(db.institutionFeeTransaction)
      ..orderBy([
        (t) => OrderingTerm(expression: t.postingDate, mode: OrderingMode.desc),
        // (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc),
      ]);

    return query.watch().map((rows) {
      try {
        for (var row in rows) {
          // This will tell us if the milliseconds survived the database trip
          print(
            "DB Row: ${row.referenceNumber} | MS: ${row.postingDate?.millisecondsSinceEpoch}",
          );
        }
        return Right(rows);
      } catch (e) {
        return Left(CacheFailure(error: e, message: e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, void>> saveInstitutionFeeTransaction({
    required InstitutionFeeTransactionData institutionFeeTransaction,
  }) async {
    try {
      await db
          .into(db.institutionFeeTransaction)
          .insertOnConflictUpdate(institutionFeeTransaction);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(error: e, message: e.toString()));
    }
  }
}
