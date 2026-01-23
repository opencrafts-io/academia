import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/institution/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

/// Watches a specific student profile by ID.
/// Returns a stream of either a failure or the profile.
class WatchProfileByIdUsecase
    extends StreamUseCase<Either<Failure, InstitutionProfile?>, int> {
  final StudentProfileRepository repository;

  WatchProfileByIdUsecase({required this.repository});

  @override
  Stream<Either<Failure, InstitutionProfile?>> call(int profileId) {
    return repository.watchProfileById(profileId: profileId);
  }
}

class WatchProfileByUserAndInstitutionUsecaseParams {
  final int institutionID;
  final String userID;

  WatchProfileByUserAndInstitutionUsecaseParams({
    required this.userID,
    required this.institutionID,
  });
}

/// Watches a specific student profile by institutionID and userID.
/// Returns a stream of either a failure or the profile.
class WatchProfileByUserAndInstitutionUsecase
    extends
        StreamUseCase<
          Either<Failure, InstitutionProfile?>,
          WatchProfileByUserAndInstitutionUsecaseParams
        > {
  final StudentProfileRepository repository;

  WatchProfileByUserAndInstitutionUsecase({required this.repository});

  @override
  Stream<Either<Failure, InstitutionProfile?>> call(
    WatchProfileByUserAndInstitutionUsecaseParams params,
  ) {
    return repository.watchProfileByUserAndInstitution(
      institutionID: params.institutionID,
      userID: params.userID,
    );
  }
}

/// Watches all profiles for a specific user.
/// Returns a stream of either a failure or a list of profiles.
class WatchProfilesByUserUsecase
    extends
        StreamUseCase<
          Either<Failure, List<InstitutionProfile>>,
          WatchProfilesByUserParams
        > {
  final StudentProfileRepository repository;

  WatchProfilesByUserUsecase({required this.repository});

  @override
  Stream<Either<Failure, List<InstitutionProfile>>> call(
    WatchProfilesByUserParams params,
  ) {
    return repository.watchProfilesByUser(userId: params.userId);
  }
}

class WatchProfilesByUserParams extends Equatable {
  final String userId;

  const WatchProfilesByUserParams({required this.userId});

  @override
  List<Object> get props => [userId];
}

/// Watches the latest profile for a specific student.
/// Returns a stream of either a failure or the latest profile.
class WatchLatestProfileByStudentUsecase
    extends
        StreamUseCase<
          Either<Failure, InstitutionProfile?>,
          WatchLatestProfileByStudentParams
        > {
  final StudentProfileRepository repository;

  WatchLatestProfileByStudentUsecase({required this.repository});

  @override
  Stream<Either<Failure, InstitutionProfile?>> call(
    WatchLatestProfileByStudentParams params,
  ) {
    return repository.watchLatestProfileByStudent(studentId: params.studentId);
  }
}

class WatchLatestProfileByStudentParams extends Equatable {
  final String studentId;

  const WatchLatestProfileByStudentParams({required this.studentId});

  @override
  List<Object> get props => [studentId];
}

// ============================================================================
// Fetch Usecases (Future-based)
// ============================================================================

/// Fetches a single profile by ID from remote and caches it locally.
class FetchProfileByIdUsecase
    extends UseCase<InstitutionProfile, FetchProfileByIdParams> {
  final StudentProfileRepository repository;

  FetchProfileByIdUsecase({required this.repository});

  @override
  Future<Either<Failure, InstitutionProfile>> call(
    FetchProfileByIdParams params,
  ) {
    return repository.fetchProfileById(profileId: params.profileId);
  }
}

class FetchProfileByIdParams extends Equatable {
  final int profileId;

  const FetchProfileByIdParams({required this.profileId});

  @override
  List<Object> get props => [profileId];
}

/// Fetches all profiles with optional filtering.
class FetchProfilesUsecase
    extends UseCase<List<InstitutionProfile>, FetchProfilesParams> {
  final StudentProfileRepository repository;

  FetchProfilesUsecase({required this.repository});

  @override
  Future<Either<Failure, List<InstitutionProfile>>> call(
    FetchProfilesParams params,
  ) {
    return repository.fetchProfiles(
      institutionId: params.institutionId,
      studentId: params.studentId,
      program: params.program,
    );
  }
}

class FetchProfilesParams extends Equatable {
  final int? institutionId;
  final String? studentId;
  final String? program;

  const FetchProfilesParams({this.institutionId, this.studentId, this.program});

  @override
  List<Object?> get props => [institutionId, studentId, program];
}

/// Fetches the current authenticated user's profile.
class FetchCurrentUserProfileUsecase
    extends UseCase<InstitutionProfile, NoParams> {
  final StudentProfileRepository repository;

  FetchCurrentUserProfileUsecase({required this.repository});

  @override
  Future<Either<Failure, InstitutionProfile>> call(NoParams params) {
    return repository.fetchCurrentUserProfile();
  }
}

/// Creates a new student profile.
class CreateProfileUsecase
    extends UseCase<InstitutionProfile, CreateProfileParams> {
  final StudentProfileRepository repository;

  CreateProfileUsecase({required this.repository});

  @override
  Future<Either<Failure, InstitutionProfile>> call(CreateProfileParams params) {
    return repository.createProfile(profile: params.profile);
  }
}

class CreateProfileParams extends Equatable {
  final InstitutionProfile profile;

  const CreateProfileParams({required this.profile});

  @override
  List<Object> get props => [profile];
}

// ============================================================================
// Update Usecases
// ============================================================================

/// Updates an existing student profile (full update).
class UpdateProfileUsecase
    extends UseCase<InstitutionProfile, UpdateProfileParams> {
  final StudentProfileRepository repository;

  UpdateProfileUsecase({required this.repository});

  @override
  Future<Either<Failure, InstitutionProfile>> call(UpdateProfileParams params) {
    return repository.updateProfile(
      profileId: params.profileId,
      profile: params.profile,
    );
  }
}

class UpdateProfileParams extends Equatable {
  final int profileId;
  final InstitutionProfile profile;

  const UpdateProfileParams({required this.profileId, required this.profile});

  @override
  List<Object> get props => [profileId, profile];
}

/// Partially updates a student profile.
class PartialUpdateProfileUsecase
    extends UseCase<InstitutionProfile, PartialUpdateProfileParams> {
  final StudentProfileRepository repository;

  PartialUpdateProfileUsecase({required this.repository});

  @override
  Future<Either<Failure, InstitutionProfile>> call(
    PartialUpdateProfileParams params,
  ) {
    return repository.partialUpdateProfile(
      profileId: params.profileId,
      updates: params.updates,
    );
  }
}

class PartialUpdateProfileParams extends Equatable {
  final int profileId;
  final Map<String, dynamic> updates;

  const PartialUpdateProfileParams({
    required this.profileId,
    required this.updates,
  });

  @override
  List<Object> get props => [profileId, updates];
}

// ============================================================================
// Delete Usecases
// ============================================================================

/// Deletes a student profile by ID.
class DeleteProfileUsecase extends UseCase<void, DeleteProfileParams> {
  final StudentProfileRepository repository;

  DeleteProfileUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(DeleteProfileParams params) {
    return repository.deleteProfile(profileId: params.profileId);
  }
}

class DeleteProfileParams extends Equatable {
  final int profileId;

  const DeleteProfileParams({required this.profileId});

  @override
  List<Object> get props => [profileId];
}

/// Deletes all profiles for a specific user.
class DeleteUserProfilesUsecase
    extends UseCase<void, DeleteUserProfilesParams> {
  final StudentProfileRepository repository;

  DeleteUserProfilesUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(DeleteUserProfilesParams params) {
    return repository.deleteUserProfiles(userId: params.userId);
  }
}

class DeleteUserProfilesParams extends Equatable {
  final String userId;

  const DeleteUserProfilesParams({required this.userId});

  @override
  List<Object> get props => [userId];
}

/// Clears all cached profiles.
class ClearProfileCacheUsecase extends UseCase<void, NoParams> {
  final StudentProfileRepository repository;

  ClearProfileCacheUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.clearCache();
  }
}
