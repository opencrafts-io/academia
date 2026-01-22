import 'package:academia/features/institution/institution.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/error/failures.dart';

abstract class StudentProfileRepository {
  /// Watches a specific student profile by ID
  /// Returns a stream of either failure or profile domain model
  Stream<Either<Failure, InstitutionProfile?>> watchProfileById({
    required int profileId,
  });

  /// Watches all profiles for a specific user
  /// Returns a stream of either failure or list of profile domain models
  Stream<Either<Failure, List<InstitutionProfile>>> watchProfilesByUser({
    required String userId,
  });

  /// Watches the latest profile for a specific student
  /// Returns a stream of either failure or profile domain model
  Stream<Either<Failure, InstitutionProfile?>> watchLatestProfileByStudent({
    required String studentId,
  });

  /// Fetches a single profile by ID from remote source
  /// and caches it locally
  Future<Either<Failure, InstitutionProfile>> fetchProfileById({
    required int profileId,
  });

  /// Fetches all profiles with optional filtering
  /// and caches them locally
  Future<Either<Failure, List<InstitutionProfile>>> fetchProfiles({
    int? institutionId,
    String? studentId,
    String? program,
  });

  /// Fetches the current authenticated user's profile
  /// and caches it locally
  Future<Either<Failure, InstitutionProfile>> fetchCurrentUserProfile();

  /// Creates a new student profile
  Future<Either<Failure, InstitutionProfile>> createProfile({
    required InstitutionProfile profile,
  });

  /// Updates an existing student profile (full update)
  Future<Either<Failure, InstitutionProfile>> updateProfile({
    required int profileId,
    required InstitutionProfile profile,
  });

  /// Partially updates an existing student profile
  Future<Either<Failure, InstitutionProfile>> partialUpdateProfile({
    required int profileId,
    required Map<String, dynamic> updates,
  });

  /// Deletes a student profile
  Future<Either<Failure, void>> deleteProfile({required int profileId});

  /// Deletes all profiles for a specific user
  Future<Either<Failure, void>> deleteUserProfiles({required String userId});

  /// Clears all cached profiles
  Future<Either<Failure, void>> clearCache();
}

