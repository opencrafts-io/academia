import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class InstitutionKeyLocalDatasource {
  final AppDataBase appDataBase;
  InstitutionKeyLocalDatasource({required this.appDataBase});

  /// Watches the most recently created [InstitutionKey] for a given institution.
  ///
  /// The stream emits:
  /// - `Right<InstitutionKeyData?>` containing the latest key if one exists
  /// - `Right(null)` if the institution has no associated keys
  ///
  /// The underlying query orders keys by `createdAt` in descending order and
  /// limits the result to a single record.
  ///
  /// If a database or cache error occurs, the stream emits a
  /// `Left<CacheFailure>` describing the failure.
  ///
  /// The stream remains active and will emit new values whenever the
  /// institution’s key set changes.
  Stream<Either<Failure, InstitutionKeyData?>> watchKeyForInstitution({
    required int institutionID,
  }) {
    return (appDataBase.select(appDataBase.institutionKey)
          ..where((ins) => ins.institutionID.equals(institutionID))
          ..orderBy([(ins) => OrderingTerm.desc(ins.createdAt)])
          ..limit(1))
        .watchSingleOrNull()
        .map<Either<Failure, InstitutionKeyData?>>((data) {
          return Right(data);
        })
        .handleError(
          (err) => Left(
            CacheFailure(
              message: "Couldn't load key set for the specified institution",
              error: err,
            ),
          ),
        );
  }

  /// Persists an [InstitutionKeyData] to the local cache.
  ///
  /// If a key with the same primary or unique constraint already exists,
  /// it will be updated using an insert-on-conflict strategy.
  ///
  /// Returns:
  /// - `Right(null)` when the operation completes successfully
  /// - `Left<CacheFailure>` if the insert or update fails
  ///
  /// This method performs a single write operation and does not emit
  /// any stream updates directly, but may trigger listeners watching
  /// the underlying table.
  Future<Either<Failure, void>> saveInstitutionKey({
    required InstitutionKeyData institutionKey,
  }) async {
    try {
      await appDataBase
          .into(appDataBase.institutionKey)
          .insertOnConflictUpdate(institutionKey);

      return right(null);
    } catch (e) {
      return left(
        CacheFailure(message: "Failed to save institution key", error: e),
      );
    }
  }
}
