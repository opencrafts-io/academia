import 'package:academia/core/core.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:dartz/dartz.dart';

/// Repository contract for managing [InstitutionKey] domain entities.
///
/// This abstraction defines how institution keys are retrieved and persisted,
/// independent of the underlying data source (cache, database, or network).
abstract class InstitutionKeyRepository {
  /// Watches the key associated with a given institution.
  ///
  /// The returned stream emits:
  /// - `Right<InstitutionKey?>` containing the current key if one exists
  /// - `Right(null)` if no key is associated with the institution
  ///
  /// Implementations should emit new values whenever the underlying data
  /// changes.
  ///
  /// If an error occurs while accessing the data source, the stream emits
  /// a `Left<Failure>` describing the failure.
  Stream<Either<Failure, InstitutionKey?>> getKeyByInstitutionID({
    required int institutionID,
  });

  /// Persists an [InstitutionKey] for an institution.
  ///
  /// Implementations may either insert a new key or update an existing one,
  /// depending on the underlying data source and conflict resolution strategy.
  ///
  /// Returns:
  /// - `Right(null)` if the operation completes successfully
  /// - `Left<Failure>` if the save operation fails
  Future<Either<Failure, void>> saveKey({
    required InstitutionKey institutionKey,
  });
}
