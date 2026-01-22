import 'package:academia/features/institution/institution.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/core/network/network.dart';

/// Default implementation of [StudentProfileRepository].
///
/// This repository acts as a bridge between the domain layer and the
/// underlying data sources. It implements an offline-first pattern where
/// local cache is the primary source of truth, with remote synchronization
/// for write operations and background syncing for reads.
///
/// The repository uses the local data source for reactive streams and
/// fallback reads, while the remote data source handles writes and
/// populates the cache.
class StudentProfileRepositoryImpl implements StudentProfileRepository {
  final InstitutionProfileRemoteDatasource remoteDatasource;
  final InstitutionProfileLocalDatasource localDatasource;
  final ConnectivityChecker connectivityChecker;

  StudentProfileRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
    required this.connectivityChecker,
  });

  /// Watches a specific student profile by ID from the local cache.
  ///
  /// The returned stream emits:
  /// - `Right<InstitutionProfile?>` containing the profile if it exists
  /// - `Right(null)` if no profile with the given ID is found
  ///
  /// The stream will continue to emit updates whenever the underlying
  /// cached data changes.
  ///
  /// If an error occurs while accessing the data source, a
  /// `Left<Failure>` is emitted.
  @override
  Stream<Either<Failure, InstitutionProfile?>> watchProfileById({
    required int profileId,
  }) {
    return localDatasource
        .watchProfileById(profileId: profileId)
        .map((either) => either.map((data) => data?.toEntity()));
  }

  /// Watches all profiles for a specific user from the local cache.
  ///
  /// The returned stream emits:
  /// - `Right<List<InstitutionProfile>>` containing all profiles for the user
  /// - `Right([])` if the user has no profiles
  ///
  /// The stream will continue to emit updates whenever the underlying
  /// cached data changes.
  ///
  /// If an error occurs while accessing the data source, a
  /// `Left<Failure>` is emitted.
  @override
  Stream<Either<Failure, List<InstitutionProfile>>> watchProfilesByUser({
    required String userId,
  }) {
    return localDatasource
        .watchProfilesByUser(userID: userId)
        .map(
          (either) => either.map(
            (dataList) => dataList.map((data) => data.toEntity()).toList(),
          ),
        );
  }

  /// Watches the latest profile for a specific student from the local cache.
  ///
  /// The returned stream emits:
  /// - `Right<InstitutionProfile?>` containing the latest profile if it exists
  /// - `Right(null)` if the student has no profiles
  ///
  /// The stream will continue to emit updates whenever the underlying
  /// cached data changes.
  ///
  /// If an error occurs while accessing the data source, a
  /// `Left<Failure>` is emitted.
  @override
  Stream<Either<Failure, InstitutionProfile?>> watchLatestProfileByStudent({
    required String studentId,
  }) {
    return localDatasource
        .watchLatestProfileByStudent(studentId: studentId)
        .map((either) => either.map((data) => data?.toEntity()));
  }

  /// Fetches a single profile by ID from the remote source and caches it locally.
  ///
  /// This method follows an offline-first pattern:
  /// 1. Checks for internet connectivity
  /// 2. Fetches from remote source if connected
  /// 3. Caches the result locally
  /// 4. Returns the cached data as a domain entity
  ///
  /// Returns:
  /// - `Right<InstitutionProfile>` on success
  /// - `Left<Failure>` if no internet connection or remote fetch fails
  @override
  Future<Either<Failure, InstitutionProfile>> fetchProfileById({
    required int profileId,
  }) async {
    if (!await connectivityChecker.isConnectedToInternet()) {
      return left(
        NetworkFailure(
          message: "No internet connection. Please check your network.",
          error: Exception("No Internet Connection"),
        ),
      );
    }

    final result = await remoteDatasource.fetchInstitutionProfileById(
      profileId: profileId,
    );

    return result.fold((failure) => left(failure), (profileData) async {
      await localDatasource.saveInstitutionProfile(
        institutionProfile: profileData,
      );
      return right(profileData.toEntity());
    });
  }

  /// Fetches all profiles with optional filtering from the remote source and caches them locally.
  ///
  /// This method follows an offline-first pattern:
  /// 1. Checks for internet connectivity
  /// 2. Fetches from remote source if connected with optional filters
  /// 3. Caches all results locally
  /// 4. Returns the cached data as domain entities
  ///
  /// Returns:
  /// - `Right<List<InstitutionProfile>>` on success
  /// - `Left<Failure>` if no internet connection or remote fetch fails
  @override
  Future<Either<Failure, List<InstitutionProfile>>> fetchProfiles({
    int? institutionId,
    String? studentId,
    String? program,
  }) async {
    if (!await connectivityChecker.isConnectedToInternet()) {
      return left(
        NetworkFailure(
          message: "No internet connection. Please check your network.",
          error: Exception("No Internet Connection"),
        ),
      );
    }

    final result = await remoteDatasource.fetchInstitutionProfiles(
      institutionId: institutionId,
      studentId: studentId,
      program: program,
    );

    return result.fold((failure) => left(failure), (profilesData) async {
      await localDatasource.saveInstitutionProfiles(
        institutionProfiles: profilesData,
      );
      return right(profilesData.map((data) => data.toEntity()).toList());
    });
  }

  /// Fetches the current authenticated user's profile from the remote source and caches it locally.
  ///
  /// This method follows an offline-first pattern:
  /// 1. Checks for internet connectivity
  /// 2. Fetches the current user's profile from remote if connected
  /// 3. Caches the result locally
  /// 4. Returns the cached data as a domain entity
  ///
  /// Returns:
  /// - `Right<InstitutionProfile>` on success
  /// - `Left<Failure>` if no internet connection or remote fetch fails
  @override
  Future<Either<Failure, InstitutionProfile>> fetchCurrentUserProfile() async {
    if (!await connectivityChecker.isConnectedToInternet()) {
      return left(
        NetworkFailure(
          message: "No internet connection. Please check your network.",
          error: Exception("No Internet Connection"),
        ),
      );
    }

    final result = await remoteDatasource.fetchCurrentUserProfile();

    return result.fold((failure) => left(failure), (profileData) async {
      await localDatasource.saveInstitutionProfile(
        institutionProfile: profileData,
      );
      return right(profileData.toEntity());
    });
  }

  /// Creates a new student profile on the remote source and caches it locally.
  ///
  /// The domain entity is mapped to its corresponding data model before
  /// being sent to the remote source. If successful, the created profile
  /// is cached locally.
  ///
  /// Returns:
  /// - `Right<InstitutionProfile>` containing the created profile on success
  /// - `Left<Failure>` if no internet connection or remote creation fails
  @override
  Future<Either<Failure, InstitutionProfile>> createProfile({
    required InstitutionProfile profile,
  }) async {
    if (!await connectivityChecker.isConnectedToInternet()) {
      return left(
        NetworkFailure(
          message: "No internet connection. Please check your network.",
          error: Exception("No Internet Connection"),
        ),
      );
    }

    final result = await remoteDatasource.createInstitutionProfile(
      profile: profile.toData(),
    );

    return result.fold((failure) => left(failure), (createdProfileData) async {
      await localDatasource.saveInstitutionProfile(
        institutionProfile: createdProfileData,
      );
      return right(createdProfileData.toEntity());
    });
  }

  /// Updates an existing student profile on the remote source and caches it locally.
  ///
  /// The domain entity is mapped to its corresponding data model before
  /// being sent to the remote source. If successful, the updated profile
  /// is cached locally, replacing the previous version.
  ///
  /// Returns:
  /// - `Right<InstitutionProfile>` containing the updated profile on success
  /// - `Left<Failure>` if no internet connection or remote update fails
  @override
  Future<Either<Failure, InstitutionProfile>> updateProfile({
    required int profileId,
    required InstitutionProfile profile,
  }) async {
    if (!await connectivityChecker.isConnectedToInternet()) {
      return left(
        NetworkFailure(
          message: "No internet connection. Please check your network.",
          error: Exception("No Internet Connection"),
        ),
      );
    }

    final result = await remoteDatasource.updateInstitutionProfile(
      profileId: profileId,
      profile: profile.toData(),
    );

    return result.fold((failure) => left(failure), (updatedProfileData) async {
      await localDatasource.saveInstitutionProfile(
        institutionProfile: updatedProfileData,
      );
      return right(updatedProfileData.toEntity());
    });
  }

  /// Partially updates an existing student profile on the remote source and caches it locally.
  ///
  /// This method allows updating specific fields without sending the entire
  /// profile object. If successful, the updated profile is cached locally.
  ///
  /// Returns:
  /// - `Right<InstitutionProfile>` containing the updated profile on success
  /// - `Left<Failure>` if no internet connection or remote update fails
  @override
  Future<Either<Failure, InstitutionProfile>> partialUpdateProfile({
    required int profileId,
    required Map<String, dynamic> updates,
  }) async {
    if (!await connectivityChecker.isConnectedToInternet()) {
      return left(
        NetworkFailure(
          message: "No internet connection. Please check your network.",
          error: Exception("No Internet Connection"),
        ),
      );
    }

    final result = await remoteDatasource.partialUpdateInstitutionProfile(
      profileId: profileId,
      updates: updates,
    );

    return result.fold((failure) => left(failure), (updatedProfileData) async {
      await localDatasource.saveInstitutionProfile(
        institutionProfile: updatedProfileData,
      );
      return right(updatedProfileData.toEntity());
    });
  }

  /// Deletes a student profile from the remote source and local cache.
  ///
  /// The deletion is performed on the remote source first. If successful,
  /// the profile is removed from the local cache.
  ///
  /// Returns:
  /// - `Right(null)` on successful deletion
  /// - `Left<Failure>` if no internet connection or remote deletion fails
  @override
  Future<Either<Failure, void>> deleteProfile({required int profileId}) async {
    if (!await connectivityChecker.isConnectedToInternet()) {
      return left(
        NetworkFailure(
          message: "No internet connection. Please check your network.",
          error: Exception("No Internet Connection"),
        ),
      );
    }

    final result = await remoteDatasource.deleteInstitutionProfile(
      profileId: profileId,
    );

    return result.fold((failure) => left(failure), (_) async {
      await localDatasource.deleteProfileById(profileId: profileId);
      return right(null);
    });
  }

  /// Deletes all profiles for a specific user from the local cache.
  ///
  /// This operation only affects the local cache and does not sync
  /// with the remote source.
  ///
  /// Returns:
  /// - `Right(null)` on successful deletion
  /// - `Left<Failure>` if the operation fails
  @override
  Future<Either<Failure, void>> deleteUserProfiles({required String userId}) {
    return localDatasource.deleteProfilesByUser(userID: userId);
  }

  /// Clears all cached profiles from the local data source.
  ///
  /// This operation only affects the local cache and does not sync
  /// with the remote source.
  ///
  /// Returns:
  /// - `Right(null)` on successful cache clear
  /// - `Left<Failure>` if the operation fails
  @override
  Future<Either<Failure, void>> clearCache() {
    return localDatasource.clearAllProfiles();
  }
}

