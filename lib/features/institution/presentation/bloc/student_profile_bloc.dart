import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/institution/institution.dart';

part 'student_profile_event.dart';
part 'student_profile_state.dart';

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
  }) : super(StudentProfileState.initial()) {
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

  Future<void> _onWatchProfileById(
    WatchProfileByIdEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));
    await emit.forEach<Either<Failure, InstitutionProfile?>>(
      watchProfileByIdUsecase(event.profileId),
      onData: (result) => result.fold(
        (f) => state.copyWith(
          status: StudentProfileStatus.error,
          failure: f,
          errorMessage: f.message,
        ),
        (p) => state.copyWith(status: StudentProfileStatus.success, profile: p),
      ),
    );
  }

  Future<void> _onWatchProfileByUserAndInstitution(
    WatchProfileByUserAndInstitutionEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));
    await emit.forEach<Either<Failure, InstitutionProfile?>>(
      watchProfilesByUserAndInstitutionUsecase(
        WatchProfileByUserAndInstitutionUsecaseParams(
          userID: event.userID,
          institutionID: event.institutionID,
        ),
      ),
      onData: (result) => result.fold(
        (f) => state.copyWith(
          status: StudentProfileStatus.error,
          failure: f,
          errorMessage: f.message,
        ),
        (p) => state.copyWith(status: StudentProfileStatus.success, profile: p),
      ),
    );
  }

  Future<void> _onWatchProfilesByUser(
    WatchProfilesByUserEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));
    await emit.forEach<Either<Failure, List<InstitutionProfile>>>(
      watchProfilesByUserUsecase(
        WatchProfilesByUserParams(userId: event.userId),
      ),
      onData: (result) => result.fold(
        (f) => state.copyWith(
          status: StudentProfileStatus.error,
          failure: f,
          errorMessage: f.message,
        ),
        (ps) =>
            state.copyWith(status: StudentProfileStatus.success, profiles: ps),
      ),
    );
  }

  Future<void> _onWatchLatestProfileByStudent(
    WatchLatestProfileByStudentEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));
    await emit.forEach<Either<Failure, InstitutionProfile?>>(
      watchLatestProfileByStudentUsecase(
        WatchLatestProfileByStudentParams(studentId: event.studentId),
      ),
      onData: (result) => result.fold(
        (f) => state.copyWith(
          status: StudentProfileStatus.error,
          failure: f,
          errorMessage: f.message,
        ),
        (p) => state.copyWith(status: StudentProfileStatus.success, profile: p),
      ),
    );
  }

  Future<void> _onFetchProfileById(
    FetchProfileByIdEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));
    final result = await fetchProfileByIdUsecase(
      FetchProfileByIdParams(profileId: event.profileId),
    );
    emit(
      result.fold(
        (f) => state.copyWith(
          status: StudentProfileStatus.error,
          failure: f,
          errorMessage: f.message,
        ),
        (p) => state.copyWith(status: StudentProfileStatus.success, profile: p),
      ),
    );
  }

  Future<void> _onFetchProfiles(
    FetchProfilesEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));
    final result = await fetchProfilesUsecase(
      FetchProfilesParams(
        institutionId: event.institutionId,
        studentId: event.studentId,
        program: event.program,
      ),
    );
    emit(
      result.fold(
        (f) => state.copyWith(
          status: StudentProfileStatus.error,
          failure: f,
          errorMessage: f.message,
        ),
        (ps) =>
            state.copyWith(status: StudentProfileStatus.success, profiles: ps),
      ),
    );
  }

  Future<void> _onFetchCurrentUserProfile(
    FetchCurrentUserProfileEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));
    final result = await fetchCurrentUserProfileUsecase(NoParams());
    emit(
      result.fold(
        (f) => state.copyWith(
          status: StudentProfileStatus.error,
          failure: f,
          errorMessage: f.message,
        ),
        (p) => state.copyWith(status: StudentProfileStatus.success),
      ),
    );
  }

  Future<void> _onCreateProfile(
    CreateProfileEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));
    final result = await createProfileUsecase(
      CreateProfileParams(profile: event.profile),
    );
    emit(
      result.fold(
        (f) => state.copyWith(
          status: StudentProfileStatus.error,
          failure: f,
          errorMessage: f.message,
        ),
        (p) => state.copyWith(
          status: StudentProfileStatus.success,
          profile: p,
          profiles: [...?state.profiles, p],
        ),
      ),
    );
  }

  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));
    final result = await updateProfileUsecase(
      UpdateProfileParams(profileId: event.profileId, profile: event.profile),
    );
    emit(
      result.fold(
        (f) => state.copyWith(
          status: StudentProfileStatus.error,
          failure: f,
          errorMessage: f.message,
        ),
        (p) => state.copyWith(
          status: StudentProfileStatus.success,
          profile: p,
          profiles: state.profiles
              ?.map((old) => old.id == p.id ? p : old)
              .toList(),
        ),
      ),
    );
  }

  Future<void> _onPartialUpdateProfile(
    PartialUpdateProfileEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));
    final result = await partialUpdateProfileUsecase(
      PartialUpdateProfileParams(
        profileId: event.profileId,
        updates: event.updates,
      ),
    );
    emit(
      result.fold(
        (f) => state.copyWith(
          status: StudentProfileStatus.error,
          failure: f,
          errorMessage: f.message,
        ),
        (p) => state.copyWith(
          status: StudentProfileStatus.success,
          profile: p,
          profiles: state.profiles
              ?.map((old) => old.id == p.id ? p : old)
              .toList(),
        ),
      ),
    );
  }

  Future<void> _onDeleteProfile(
    DeleteProfileEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));
    final result = await deleteProfileUsecase(
      DeleteProfileParams(profileId: event.profileId),
    );
    emit(
      result.fold(
        (f) => state.copyWith(
          status: StudentProfileStatus.error,
          failure: f,
          errorMessage: f.message,
        ),
        (_) => state.copyWith(
          status: StudentProfileStatus.success,
          profile: null,
          profiles: state.profiles
              ?.where((p) => p.id != event.profileId)
              .toList(),
        ),
      ),
    );
  }

  Future<void> _onDeleteUserProfiles(
    DeleteUserProfilesEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));
    final result = await deleteUserProfilesUsecase(
      DeleteUserProfilesParams(userId: event.userId),
    );
    emit(
      result.fold(
        (f) => state.copyWith(
          status: StudentProfileStatus.error,
          failure: f,
          errorMessage: f.message,
        ),
        (_) => state.copyWith(
          status: StudentProfileStatus.success,
          profile: null,
          profiles: [],
        ),
      ),
    );
  }

  Future<void> _onClearProfileCache(
    ClearProfileCacheEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));
    final result = await clearProfileCacheUsecase(NoParams());
    emit(
      result.fold(
        (f) => state.copyWith(
          status: StudentProfileStatus.error,
          failure: f,
          errorMessage: f.message,
        ),
        (_) => state.copyWith(
          status: StudentProfileStatus.success,
          profile: null,
          profiles: [],
        ),
      ),
    );
  }
}
