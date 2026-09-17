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
  /// - `Right<InstitutionKey?>` containing the latest key if one exists
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
  Stream<Either<Failure, InstitutionKey?>> watchKeyForInstitution({
    required int institutionID,
  }) {
    return (appDataBase.select(appDataBase.institutionKeys)
          ..where((ins) => ins.institutionID.equals(institutionID))
          ..orderBy([(ins) => OrderingTerm.desc(ins.createdAt)])
          ..limit(1))
        .watchSingleOrNull()
        .map<Either<Failure, InstitutionKey?>>((data) {
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

  /// Blanks the `keySets` value of a legacy plaintext row, without deleting
  /// the row itself. Used once a row's key set has been migrated to secure
  /// storage, so the plaintext credentials don't linger on disk. This is a
  /// plain data update (`UPDATE ... SET key_sets = ...`), not a schema
  /// migration.
  Future<Either<Failure, void>> blankKeySets({
    required int institutionID,
    required String commandID,
  }) async {
    try {
      await (appDataBase.update(appDataBase.institutionKeys)..where(
            (k) =>
                k.institutionID.equals(institutionID) &
                k.commandID.equals(commandID),
          ))
          .write(const InstitutionKeysCompanion(keySets: Value({})));
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          message: "Failed to clear the legacy institution key cache",
          error: e,
        ),
      );
    }
  }
}
