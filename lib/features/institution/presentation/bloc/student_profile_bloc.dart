import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/institution/institution.dart';

export 'student_profile_state.dart';

part 'student_profile_event.dart';

class StudentProfileBloc
    extends Bloc<StudentProfileEvent, StudentProfileState> {
  final WatchProfileByIdUsecase watchProfileByIdUsecase;
  final WatchProfileByUserAndInstitutionUsecase
  watchProfilesByUserAndInstitutionUsecase;
  final WatchProfilesByUserUsecase watchProfilesByUserUsecase;
  final WatchLatestProfileByStudentUsecase watchLatestProfileByStudentUsecase;
  final FetchProfileByIdUsecase fetchProfileByIdUsecase;
  final FetchProfilesUsecase fetchProfilesUsecase;
  final FetchCurrentUserProfileUsecase fetchCurrentUserProfileUsecase;
  final CreateProfileUsecase createProfileUsecase;
  final UpdateProfileUsecase updateProfileUsecase;
  final PartialUpdateProfileUsecase partialUpdateProfileUsecase;
  final DeleteProfileUsecase deleteProfileUsecase;
  final DeleteUserProfilesUsecase deleteUserProfilesUsecase;
  final ClearProfileCacheUsecase clearProfileCacheUsecase;

  StudentProfileBloc({
    required this.watchProfileByIdUsecase,
    required this.watchProfilesByUserAndInstitutionUsecase,
    required this.watchProfilesByUserUsecase,
    required this.watchLatestProfileByStudentUsecase,
    required this.fetchProfileByIdUsecase,
    required this.fetchProfilesUsecase,
    required this.fetchCurrentUserProfileUsecase,
    required this.createProfileUsecase,
    required this.updateProfileUsecase,
    required this.partialUpdateProfileUsecase,
    required this.deleteProfileUsecase,
    required this.deleteUserProfilesUsecase,
    required this.clearProfileCacheUsecase,
  }) : super(const StudentProfileState.initial()) {
    // Watch Events (Streams)
    on<WatchProfileByIdEvent>(_onWatchProfileById);
    on<WatchProfileByUserAndInstitutionEvent>(
      _onWatchProfileByUserAndInstitution,
    );
    on<WatchProfilesByUserEvent>(_onWatchProfilesByUser);
    on<WatchLatestProfileByStudentEvent>(_onWatchLatestProfileByStudent);

    // Fetch/Action Events (Futures)
    on<FetchProfileByIdEvent>(_onFetchProfileById);
    on<FetchProfilesEvent>(_onFetchProfiles);
    on<FetchCurrentUserProfileEvent>(_onFetchCurrentUserProfile);
    on<CreateProfileEvent>(_onCreateProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<PartialUpdateProfileEvent>(_onPartialUpdateProfile);
    on<DeleteProfileEvent>(_onDeleteProfile);
    on<DeleteUserProfilesEvent>(_onDeleteUserProfiles);
    on<ClearProfileCacheEvent>(_onClearProfileCache);
  }

  /// The profiles accumulated by the current `success` state, or an empty
  /// list if the state doesn't carry any (e.g. right after emitting loading).
  List<InstitutionProfile> get _currentProfiles =>
      state.mapOrNull(success: (s) => s.profiles) ?? [];

  Future<void> _onWatchProfileById(
    WatchProfileByIdEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(const StudentProfileState.loading());
    await emit.forEach<Either<Failure, InstitutionProfile?>>(
      watchProfileByIdUsecase(event.profileId),
      onData: (result) => result.fold(
        (f) => StudentProfileState.error(message: f.message, failure: f),
        (p) => StudentProfileState.success(profile: p),
      ),
    );
  }

  Future<void> _onWatchProfileByUserAndInstitution(
    WatchProfileByUserAndInstitutionEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(const StudentProfileState.loading());
    await emit.forEach<Either<Failure, InstitutionProfile?>>(
      watchProfilesByUserAndInstitutionUsecase(
        WatchProfileByUserAndInstitutionUsecaseParams(
          userID: event.userID,
          institutionID: event.institutionID,
        ),
      ),
      onData: (result) => result.fold(
        (f) => StudentProfileState.error(message: f.message, failure: f),
        (p) => StudentProfileState.success(profile: p),
      ),
    );
  }

  Future<void> _onWatchProfilesByUser(
    WatchProfilesByUserEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(const StudentProfileState.loading());
    await emit.forEach<Either<Failure, List<InstitutionProfile>>>(
      watchProfilesByUserUsecase(
        WatchProfilesByUserParams(userId: event.userId),
      ),
      onData: (result) => result.fold(
        (f) => StudentProfileState.error(message: f.message, failure: f),
        (ps) => StudentProfileState.success(profiles: ps),
      ),
    );
  }

  Future<void> _onWatchLatestProfileByStudent(
    WatchLatestProfileByStudentEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(const StudentProfileState.loading());
    await emit.forEach<Either<Failure, InstitutionProfile?>>(
      watchLatestProfileByStudentUsecase(
        WatchLatestProfileByStudentParams(studentId: event.studentId),
      ),
      onData: (result) => result.fold(
        (f) => StudentProfileState.error(message: f.message, failure: f),
        (p) => StudentProfileState.success(profile: p),
      ),
    );
  }

  Future<void> _onFetchProfileById(
    FetchProfileByIdEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(const StudentProfileState.loading());
    final result = await fetchProfileByIdUsecase(
      FetchProfileByIdParams(profileId: event.profileId),
    );
    emit(
      result.fold(
        (f) => StudentProfileState.error(message: f.message, failure: f),
        (p) => StudentProfileState.success(profile: p),
      ),
    );
  }

  Future<void> _onFetchProfiles(
    FetchProfilesEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(const StudentProfileState.loading());
    final result = await fetchProfilesUsecase(
      FetchProfilesParams(
        institutionId: event.institutionId,
        studentId: event.studentId,
        program: event.program,
      ),
    );
    emit(
      result.fold(
        (f) => StudentProfileState.error(message: f.message, failure: f),
        (ps) => StudentProfileState.success(profiles: ps),
      ),
    );
  }

  Future<void> _onFetchCurrentUserProfile(
    FetchCurrentUserProfileEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(const StudentProfileState.loading());
    final result = await fetchCurrentUserProfileUsecase(NoParams());
    emit(
      result.fold(
        (f) => StudentProfileState.error(message: f.message, failure: f),
        (p) => const StudentProfileState.success(),
      ),
    );
  }

  Future<void> _onCreateProfile(
    CreateProfileEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    final previousProfiles = _currentProfiles;
    emit(const StudentProfileState.loading());
    final result = await createProfileUsecase(
      CreateProfileParams(profile: event.profile),
    );
    emit(
      result.fold(
        (f) => StudentProfileState.error(message: f.message, failure: f),
        (p) => StudentProfileState.success(
          profile: p,
          profiles: [...previousProfiles, p],
        ),
      ),
    );
  }

  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    final previousProfiles = _currentProfiles;
    emit(const StudentProfileState.loading());
    final result = await updateProfileUsecase(
      UpdateProfileParams(profileId: event.profileId, profile: event.profile),
    );
    emit(
      result.fold(
        (f) => StudentProfileState.error(message: f.message, failure: f),
        (p) => StudentProfileState.success(
          profile: p,
          profiles: previousProfiles
              .map((old) => old.id == p.id ? p : old)
              .toList(),
        ),
      ),
    );
  }

  Future<void> _onPartialUpdateProfile(
    PartialUpdateProfileEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    final previousProfiles = _currentProfiles;
    emit(const StudentProfileState.loading());
    final result = await partialUpdateProfileUsecase(
      PartialUpdateProfileParams(
        profileId: event.profileId,
        updates: event.updates,
      ),
    );
    emit(
      result.fold(
        (f) => StudentProfileState.error(message: f.message, failure: f),
        (p) => StudentProfileState.success(
          profile: p,
          profiles: previousProfiles
              .map((old) => old.id == p.id ? p : old)
              .toList(),
        ),
      ),
    );
  }

  Future<void> _onDeleteProfile(
    DeleteProfileEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    final previousProfiles = _currentProfiles;
    emit(const StudentProfileState.loading());
    final result = await deleteProfileUsecase(
      DeleteProfileParams(profileId: event.profileId),
    );
    emit(
      result.fold(
        (f) => StudentProfileState.error(message: f.message, failure: f),
        (_) => StudentProfileState.success(
          profiles: previousProfiles
              .where((p) => p.id != event.profileId)
              .toList(),
        ),
      ),
    );
  }

  Future<void> _onDeleteUserProfiles(
    DeleteUserProfilesEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(const StudentProfileState.loading());
    final result = await deleteUserProfilesUsecase(
      DeleteUserProfilesParams(userId: event.userId),
    );
    emit(
      result.fold(
        (f) => StudentProfileState.error(message: f.message, failure: f),
        (_) => const StudentProfileState.success(),
      ),
    );
  }

  Future<void> _onClearProfileCache(
    ClearProfileCacheEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(const StudentProfileState.loading());
    final result = await clearProfileCacheUsecase(NoParams());
    emit(
      result.fold(
        (f) => StudentProfileState.error(message: f.message, failure: f),
        (_) => const StudentProfileState.success(),
      ),
    );
  }
}
