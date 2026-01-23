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

  StreamSubscription<Either<Failure, InstitutionProfile?>>?
  _watchProfileByIdSubscription;
  StreamSubscription<Either<Failure, List<InstitutionProfile>>>?
  _watchProfilesByUserSubscription;
  StreamSubscription<Either<Failure, InstitutionProfile?>>?
  _watchLatestProfileSubscription;

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
    on<WatchProfileByIdEvent>(_onWatchProfileById);
    on<WatchProfileByUserAndInstitutionEvent>(
      _onWatchProfileByUserAndInstitution,
    );
    on<WatchProfilesByUserEvent>(_onWatchProfilesByUser);
    on<WatchLatestProfileByStudentEvent>(_onWatchLatestProfileByStudent);
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

  // Watch Handlers

  Future<void> _onWatchProfileById(
    WatchProfileByIdEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));

    await _watchProfileByIdSubscription?.cancel();
    _watchProfileByIdSubscription = watchProfileByIdUsecase
        .call(event.profileId)
        .listen(
          (either) {
            either.fold(
              (failure) {
                add(
                  StudentProfileErrorEvent(
                    message: failure.message,
                    failure: failure,
                  ),
                );
              },
              (profile) {
                add(ProfileLoadedEvent(profile: profile));
              },
            );
          },
          onError: (error) {
            add(
              StudentProfileErrorEvent(
                message: "Error watching profile",
                failure: ServerFailure(
                  message: "Error watching profile",
                  error: error,
                ),
              ),
            );
          },
        );
  }

  Future<void> _onWatchProfileByUserAndInstitution(
    WatchProfileByUserAndInstitutionEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));

    await _watchProfileByIdSubscription?.cancel();
    _watchProfileByIdSubscription = watchProfilesByUserAndInstitutionUsecase
        .call(
          WatchProfileByUserAndInstitutionUsecaseParams(
            userID: event.userID,
            institutionID: event.institutionID,
          ),
        )
        .listen(
          (either) {
            either.fold(
              (failure) {
                add(
                  StudentProfileErrorEvent(
                    message: failure.message,
                    failure: failure,
                  ),
                );
              },
              (profile) {
                add(ProfileLoadedEvent(profile: profile));
              },
            );
          },
          onError: (error) {
            add(
              StudentProfileErrorEvent(
                message: "Error watching profile",
                failure: ServerFailure(
                  message: "Error watching profile",
                  error: error,
                ),
              ),
            );
          },
        );
  }

  Future<void> _onWatchProfilesByUser(
    WatchProfilesByUserEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));

    await _watchProfilesByUserSubscription?.cancel();
    _watchProfilesByUserSubscription = watchProfilesByUserUsecase
        .call(WatchProfilesByUserParams(userId: event.userId))
        .listen(
          (either) {
            either.fold(
              (failure) {
                add(
                  StudentProfileErrorEvent(
                    message: failure.message,
                    failure: failure,
                  ),
                );
              },
              (profiles) {
                add(ProfilesLoadedEvent(profiles: profiles));
              },
            );
          },
          onError: (error) {
            add(
              StudentProfileErrorEvent(
                message: "Error watching user profiles",
                failure: ServerFailure(
                  message: "Error watching user profiles",
                  error: error,
                ),
              ),
            );
          },
        );
  }

  Future<void> _onWatchLatestProfileByStudent(
    WatchLatestProfileByStudentEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));

    await _watchLatestProfileSubscription?.cancel();
    _watchLatestProfileSubscription = watchLatestProfileByStudentUsecase
        .call(WatchLatestProfileByStudentParams(studentId: event.studentId))
        .listen(
          (either) {
            either.fold(
              (failure) {
                add(
                  StudentProfileErrorEvent(
                    message: failure.message,
                    failure: failure,
                  ),
                );
              },
              (profile) {
                add(LatestProfileLoadedEvent(profile: profile));
              },
            );
          },
          onError: (error) {
            add(
              StudentProfileErrorEvent(
                message: "Error watching latest profile",
                failure: ServerFailure(
                  message: "Error watching latest profile",
                  error: error,
                ),
              ),
            );
          },
        );
  }

  // Fetch Handlers

  Future<void> _onFetchProfileById(
    FetchProfileByIdEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));

    final result = await fetchProfileByIdUsecase.call(
      FetchProfileByIdParams(profileId: event.profileId),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: StudentProfileStatus.error,
            errorMessage: failure.message,
            failure: failure,
          ),
        );
      },
      (profile) {
        emit(
          state.copyWith(
            status: StudentProfileStatus.success,
            profile: profile,
          ),
        );
      },
    );
  }

  Future<void> _onFetchProfiles(
    FetchProfilesEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));

    final result = await fetchProfilesUsecase.call(
      FetchProfilesParams(
        institutionId: event.institutionId,
        studentId: event.studentId,
        program: event.program,
      ),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: StudentProfileStatus.error,
            errorMessage: failure.message,
            failure: failure,
          ),
        );
      },
      (profiles) {
        emit(
          state.copyWith(
            status: StudentProfileStatus.success,
            profiles: profiles,
          ),
        );
      },
    );
  }

  Future<void> _onFetchCurrentUserProfile(
    FetchCurrentUserProfileEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));

    final result = await fetchCurrentUserProfileUsecase.call(NoParams());

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: StudentProfileStatus.error,
            errorMessage: failure.message,
            failure: failure,
          ),
        );
      },
      (profile) {
        emit(
          state.copyWith(
            status: StudentProfileStatus.success,
            profile: profile,
          ),
        );
      },
    );
  }

  // Create Handler

  Future<void> _onCreateProfile(
    CreateProfileEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));

    final result = await createProfileUsecase.call(
      CreateProfileParams(profile: event.profile),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: StudentProfileStatus.error,
            errorMessage: failure.message,
            failure: failure,
          ),
        );
      },
      (createdProfile) {
        emit(
          state.copyWith(
            status: StudentProfileStatus.success,
            profile: createdProfile,
            profiles: [...?state.profiles, createdProfile],
          ),
        );
      },
    );
  }

  // Update Handlers

  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));

    final result = await updateProfileUsecase.call(
      UpdateProfileParams(profileId: event.profileId, profile: event.profile),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: StudentProfileStatus.error,
            errorMessage: failure.message,
            failure: failure,
          ),
        );
      },
      (updatedProfile) {
        final updatedProfiles = state.profiles
            ?.map((p) => p.id == updatedProfile.id ? updatedProfile : p)
            .toList();

        emit(
          state.copyWith(
            status: StudentProfileStatus.success,
            profile: updatedProfile,
            profiles: updatedProfiles,
          ),
        );
      },
    );
  }

  Future<void> _onPartialUpdateProfile(
    PartialUpdateProfileEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));

    final result = await partialUpdateProfileUsecase.call(
      PartialUpdateProfileParams(
        profileId: event.profileId,
        updates: event.updates,
      ),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: StudentProfileStatus.error,
            errorMessage: failure.message,
            failure: failure,
          ),
        );
      },
      (updatedProfile) {
        final updatedProfiles = state.profiles
            ?.map((p) => p.id == updatedProfile.id ? updatedProfile : p)
            .toList();

        emit(
          state.copyWith(
            status: StudentProfileStatus.success,
            profile: updatedProfile,
            profiles: updatedProfiles,
          ),
        );
      },
    );
  }

  // Delete Handlers

  Future<void> _onDeleteProfile(
    DeleteProfileEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));

    final result = await deleteProfileUsecase.call(
      DeleteProfileParams(profileId: event.profileId),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: StudentProfileStatus.error,
            errorMessage: failure.message,
            failure: failure,
          ),
        );
      },
      (_) {
        final updatedProfiles = state.profiles
            ?.where((p) => p.id != event.profileId)
            .toList();

        emit(
          state.copyWith(
            status: StudentProfileStatus.success,
            profile: null,
            profiles: updatedProfiles,
          ),
        );
      },
    );
  }

  Future<void> _onDeleteUserProfiles(
    DeleteUserProfilesEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));

    final result = await deleteUserProfilesUsecase.call(
      DeleteUserProfilesParams(userId: event.userId),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: StudentProfileStatus.error,
            errorMessage: failure.message,
            failure: failure,
          ),
        );
      },
      (_) {
        emit(
          state.copyWith(
            status: StudentProfileStatus.success,
            profile: null,
            profiles: [],
          ),
        );
      },
    );
  }

  Future<void> _onClearProfileCache(
    ClearProfileCacheEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(status: StudentProfileStatus.loading));

    final result = await clearProfileCacheUsecase.call(NoParams());

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: StudentProfileStatus.error,
            errorMessage: failure.message,
            failure: failure,
          ),
        );
      },
      (_) {
        emit(
          state.copyWith(
            status: StudentProfileStatus.success,
            profile: null,
            profiles: [],
          ),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    await _watchProfileByIdSubscription?.cancel();
    await _watchProfilesByUserSubscription?.cancel();
    await _watchLatestProfileSubscription?.cancel();
    await super.close();
  }
}
