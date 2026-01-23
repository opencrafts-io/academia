import 'package:academia/core/error/failures.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class InstitutionProfileLocalDatasource {
  final AppDataBase appDataBase;

  InstitutionProfileLocalDatasource({required this.appDataBase});

  /// Watches a specific [InstitutionProfileData] by its ID.
  ///
  /// The stream emits:
  /// - `Right<InstitutionProfile?>` containing the profile if it exists
  /// - `Right(null)` if no profile with the given ID is found
  ///
  /// If a database or cache error occurs, the stream emits a
  /// `Left<CacheFailure>` describing the failure.
  ///
  /// The stream remains active and will emit new values whenever the
  /// profile is updated.
  Stream<Either<Failure, InstitutionProfileData?>> watchProfileById({
    required int profileId,
  }) {
    return (appDataBase.select(appDataBase.institutionProfile)
          ..where((profile) => profile.id.equals(profileId)))
        .watchSingleOrNull()
        .map<Either<Failure, InstitutionProfileData?>>((data) {
          return Right(data);
        })
        .handleError(
          (err) => Left(
            CacheFailure(
              message: "Couldn't load profile with the specified ID",
              error: err,
            ),
          ),
        );
  }

  /// Watches a specific [InstitutionProfileData] by its
  /// linked [userID] and [institutionID].
  ///
  /// The stream emits:
  /// - `Right<InstitutionProfile?>` containing the profile if it exists
  /// - `Right(null)` if no profile with the given ID is found
  ///
  /// If a database or cache error occurs, the stream emits a
  /// `Left<CacheFailure>` describing the failure.
  ///
  /// The stream remains active and will emit new values whenever the
  /// profile is updated.

  Stream<Either<Failure, InstitutionProfileData?>>
  watchProfileByUserAndInstitution({
    required String userID,
    required int institutionID,
  }) {
    return (appDataBase.select(appDataBase.institutionProfile)..where(
          (profile) =>
              profile.userID.equals(userID) &
              profile.institutionID.equals(institutionID),
        ))
        .watchSingleOrNull()
        .map<Either<Failure, InstitutionProfileData?>>((data) {
          return Right(data);
        })
        .handleError(
          (err) => Left(
            CacheFailure(
              message: "Couldn't load profile with the specified ID",
              error: err,
            ),
          ),
        );
  }

  /// Watches all [InstitutionProfileData]s for a given user.
  ///
  /// The stream emits:
  /// - `Right<List<InstitutionProfile>>` containing all profiles for the user
  /// - `Right([])` if the user has no associated profiles
  ///
  /// Results are ordered by `createdAt` in descending order (most recent first).
  ///
  /// If a database or cache error occurs, the stream emits a
  /// `Left<CacheFailure>` describing the failure.
  ///
  /// The stream remains active and will emit new values whenever the
  /// user's profile set changes.
  Stream<Either<Failure, List<InstitutionProfileData>>> watchProfilesByUser({
    required String userID,
  }) {
    return (appDataBase.select(appDataBase.institutionProfile)
          ..where((profile) => profile.userID.equals(userID))
          ..orderBy([(profile) => OrderingTerm.desc(profile.createdAt)]))
        .watch()
        .map<Either<Failure, List<InstitutionProfileData>>>((profiles) {
          return Right(profiles);
        })
        .handleError(
          (err) => Left(
            CacheFailure(
              message: "Couldn't load profiles for the specified user",
              error: err,
            ),
          ),
        );
  }

  /// Watches the most recently created [InstitutionProfile] for a given student.
  ///
  /// The stream emits:
  /// - `Right<InstitutionProfile?>` containing the latest profile if one exists
  /// - `Right(null)` if the student has no associated profiles
  ///
  /// The underlying query orders profiles by `createdAt` in descending order
  /// and limits the result to a single record.
  ///
  /// If a database or cache error occurs, the stream emits a
  /// `Left<CacheFailure>` describing the failure.
  ///
  /// The stream remains active and will emit new values whenever the
  /// student's profile set changes.
  Stream<Either<Failure, InstitutionProfileData?>> watchLatestProfileByStudent({
    required String studentId,
  }) {
    return (appDataBase.select(appDataBase.institutionProfile)
          ..where((profile) => profile.studentID.equals(studentId))
          ..orderBy([(profile) => OrderingTerm.desc(profile.createdAt)])
          ..limit(1))
        .watchSingleOrNull()
        .map<Either<Failure, InstitutionProfileData?>>((data) {
          return Right(data);
        })
        .handleError(
          (err) => Left(
            CacheFailure(
              message: "Couldn't load profile set for the specified student",
              error: err,
            ),
          ),
        );
  }

  /// Persists an [InstitutionProfileData] to the local cache.
  ///
  /// If a profile with the same primary or unique constraint already exists,
  /// it will be updated using an insert-on-conflict strategy.
  ///
  /// Returns:
  /// - `Right(null)` when the operation completes successfully
  /// - `Left<CacheFailure>` if the insert or update fails
  ///
  /// This method performs a single write operation and does not emit
  /// any stream updates directly, but may trigger listeners watching
  /// the underlying table.
  Future<Either<Failure, void>> saveInstitutionProfile({
    required InstitutionProfileData institutionProfile,
  }) async {
    try {
      await appDataBase
          .into(appDataBase.institutionProfile)
          .insertOnConflictUpdate(institutionProfile);
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(message: "Failed to save institution profile", error: e),
      );
    }
  }

  /// Persists multiple [InstitutionProfile]s to the local cache in a batch.
  ///
  /// If profiles with the same primary or unique constraints already exist,
  /// they will be updated using an insert-on-conflict strategy.
  ///
  /// Returns:
  /// - `Right(null)` when all profiles are persisted successfully
  /// - `Left<CacheFailure>` if any insert or update fails
  ///
  /// This method performs a batch write operation for efficiency.
  Future<Either<Failure, void>> saveInstitutionProfiles({
    required List<InstitutionProfileData> institutionProfiles,
  }) async {
    try {
      await appDataBase.batch((batch) {
        batch.insertAllOnConflictUpdate(
          appDataBase.institutionProfile,
          institutionProfiles,
        );
      });
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(message: "Failed to save institution profiles", error: e),
      );
    }
  }

  /// Deletes an [InstitutionProfile] by its ID.
  ///
  /// Returns:
  /// - `Right(null)` when the profile is deleted successfully
  /// - `Left<CacheFailure>` if the delete operation fails
  Future<Either<Failure, void>> deleteProfileById({
    required int profileId,
  }) async {
    try {
      await (appDataBase.delete(
        appDataBase.institutionProfile,
      )..where((profile) => profile.id.equals(profileId))).go();
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(message: "Failed to delete institution profile", error: e),
      );
    }
  }

  /// Deletes all [InstitutionProfileData]s for a given user.
  ///
  /// Returns:
  /// - `Right(null)` when all profiles are deleted successfully
  /// - `Left<CacheFailure>` if the delete operation fails
  Future<Either<Failure, void>> deleteProfilesByUser({
    required String userID,
  }) async {
    try {
      await (appDataBase.delete(
        appDataBase.institutionProfile,
      )..where((profile) => profile.userID.equals(userID))).go();
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          message: "Failed to delete profiles for the specified user",
          error: e,
        ),
      );
    }
  }

  /// Clears all [InstitutionProfileData]s from the local cache.
  ///
  /// Returns:
  /// - `Right(null)` when all profiles are cleared successfully
  /// - `Left<CacheFailure>` if the clear operation fails
  Future<Either<Failure, void>> clearAllProfiles() async {
    try {
      await appDataBase.delete(appDataBase.institutionProfile).go();
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(message: "Failed to clear institution profiles", error: e),
      );
    }
  }
}
