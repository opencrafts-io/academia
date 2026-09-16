import 'package:academia/core/error/failures.dart';
import 'package:academia/features/institution/data/data.dart';
import 'package:academia/features/institution/domain/domain.dart';
import 'package:dartz/dartz.dart';

/// Default implementation of [InstitutionKeyRepository].
///
/// Institution keys (portal login credentials) are stored in
/// [InstitutionKeySecureDatasource], which is authoritative for every new
/// save. [localDataSource] is kept only to lazily migrate any legacy
/// plaintext row that was written before this datasource existed — once
/// migrated, that row's key set is blanked and secure storage serves every
/// subsequent read.
class InstitutionKeyRepositoryImpl extends InstitutionKeyRepository {
  final InstitutionKeyLocalDatasource localDataSource;
  final InstitutionKeySecureDatasource secureDataSource;

  InstitutionKeyRepositoryImpl({
    required this.localDataSource,
    required this.secureDataSource,
  });

  /// Persists an [InstitutionKey] to secure storage.
  ///
  /// Returns:
  /// - `Right(null)` when the save operation succeeds
  /// - `Left<Failure>` if the operation fails
  @override
  Future<Either<Failure, void>> saveKey({
    required InstitutionKey institutionKey,
  }) {
    return secureDataSource.saveInstitutionKey(institutionKey);
  }

  /// Returns the institution key associated with the given institution.
  ///
  /// Reads secure storage first. If nothing has been saved there yet, falls
  /// back to a one-time migration of any legacy plaintext row from the local
  /// cache, after which secure storage is authoritative.
  ///
  /// The returned stream emits:
  /// - `Right<InstitutionKey?>` containing the current key if one exists
  /// - `Right(null)` if the institution has no associated key
  /// - `Left<Failure>` if an error occurs while accessing storage
  @override
  Stream<Either<Failure, InstitutionKey?>> getKeyByInstitutionID({
    required int institutionID,
  }) async* {
    final secureResult = await secureDataSource.getInstitutionKey(
      institutionID,
    );
    if (secureResult.isLeft()) {
      yield secureResult;
      return;
    }

    final existingKey = secureResult.fold((_) => null, (key) => key);
    if (existingKey != null) {
      yield right(existingKey);
      return;
    }

    // Nothing in secure storage yet -- check for a legacy plaintext row to
    // lazily migrate, then secure storage is authoritative from here on.
    final legacyResult = await localDataSource
        .watchKeyForInstitution(institutionID: institutionID)
        .first;
    final legacyData = legacyResult.fold((_) => null, (data) => data);

    if (legacyData == null) {
      yield legacyResult.fold((failure) => left(failure), (_) => right(null));
      return;
    }

    final legacyKey = legacyData.toEntity();
    final migrateResult = await secureDataSource.saveInstitutionKey(legacyKey);
    if (migrateResult.isRight()) {
      await localDataSource.blankKeySets(
        institutionID: legacyData.institutionID,
        commandID: legacyData.commandID,
      );
    }
    yield right(legacyKey);
  }
}
