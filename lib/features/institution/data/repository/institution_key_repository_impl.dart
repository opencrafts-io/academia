import 'package:academia/core/error/failures.dart';
import 'package:academia/features/institution/data/data.dart';
import 'package:academia/features/institution/domain/domain.dart';
import 'package:dartz/dartz.dart';

/// Default implementation of [InstitutionKeyRepository].
///
/// This repository acts as a bridge between the domain layer and the
/// underlying data source responsible for persisting institution keys.
///
/// The current implementation relies on a local cache-backed data source
/// and exposes reactive read access via streams.
class InstitutionKeyRepositoryImpl extends InstitutionKeyRepository {
  final InstitutionKeyLocalDatasource localDataSource;

  InstitutionKeyRepositoryImpl({required this.localDataSource});

  /// Persists an [InstitutionKey] to the local data source.
  ///
  /// The domain entity is mapped to its corresponding data model before
  /// being saved. If a key already exists for the same identity, it may
  /// be updated depending on the data source’s conflict resolution strategy.
  ///
  /// Returns:
  /// - `Right(null)` when the save operation succeeds
  /// - `Left<Failure>` if the operation fails
  @override
  Future<Either<Failure, void>> saveKey({
    required InstitutionKey institutionKey,
  }) {
    return localDataSource.saveInstitutionKey(
      institutionKey: institutionKey.toData(),
    );
  }

  /// Watches the institution key associated with the given institution.
  ///
  /// The returned stream emits:
  /// - `Right<InstitutionKey?>` containing the current key if one exists
  /// - `Right(null)` if the institution has no associated key
  ///
  /// The stream will continue to emit updates whenever the underlying
  /// cached data changes.
  ///
  /// If an error occurs while accessing the data source, a
  /// `Left<Failure>` is emitted.
  @override
  Stream<Either<Failure, InstitutionKey?>> getKeyByInstitutionID({
    required int institutionID,
  }) {
    return localDataSource
        .watchKeyForInstitution(institutionID: institutionID)
        .map((either) => either.map((data) => data?.toEntity()));
  }
}
