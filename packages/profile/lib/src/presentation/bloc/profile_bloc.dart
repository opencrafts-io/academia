import 'dart:async';

import 'package:analytics/analytics.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:notifications/notifications.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases.dart';
import '../../domain/user_profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required this.refreshCurrentUserProfileUsecase,
    required this.updateUserProfile,
    required this.updateUserPhone,
    required this.getCachedProfileUsecase,
    required this.clearCachedProfileUsecase,
    required this.requestAccountDeletionUsecase,
    required this.requestAccountRecoveryUsecase,
    required this.analyticsTracker,
    required this.notificationIdentityService,
  }) : super(const ProfileInitialState()) {
    on<ProfileEvent>(_handleEvent, transformer: sequential());
  }

  final RefreshCurrentUserProfileUsecase refreshCurrentUserProfileUsecase;
  final UpdateUserProfile updateUserProfile;
  final UpdateUserPhone updateUserPhone;
  final GetCachedProfileUsecase getCachedProfileUsecase;
  final ClearCachedProfileUsecase clearCachedProfileUsecase;
  final RequestAccountDeletionUsecase requestAccountDeletionUsecase;
  final RequestAccountRecoveryUsecase requestAccountRecoveryUsecase;
  final AnalyticsTracker analyticsTracker;
  final NotificationIdentityService notificationIdentityService;
  final Logger _logger = Logger();

  Future<void> _handleEvent(
    ProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    if (event is RefreshProfileEvent) {
      await _refresh(emit);
    } else if (event is GetCachedProfileEvent) {
      await _getCached(emit);
    } else if (event is UpdateUserProfileEvent) {
      await _updateProfile(event.profile, emit);
    } else if (event is UpdateUserPhoneEvent) {
      await _updatePhone(event.profile, emit);
    } else if (event is RequestAccountDeletionEvent) {
      await _requestDeletion(emit);
    } else if (event is RequestAccountRecoveryEvent) {
      await _requestRecovery(emit);
    } else if (event is ClearCachedProfileEvent) {
      await _clearCache(emit);
    }
  }

  Future<void> _refresh(Emitter<ProfileState> emit) async {
    emit(const ProfileLoadingstate());
    final result = await refreshCurrentUserProfileUsecase(
      const NoUseCaseParams(),
    );
    if (emit.isDone) return;
    result.fold((failure) => _emitFailure(failure, emit), (profile) {
      _identifyProfile(profile);
      emit(ProfileLoadedState(profile: profile));
    });
  }

  Future<void> _getCached(Emitter<ProfileState> emit) async {
    emit(const ProfileLoadingstate());
    final result = await getCachedProfileUsecase(const NoUseCaseParams());
    if (emit.isDone) return;
    result.fold((failure) => _emitFailure(failure, emit), (profile) {
      emit(ProfileLoadedState(profile: profile));
    });
  }

  Future<void> _updateProfile(
    UserProfile profile,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoadingstate());
    final result = await updateUserProfile(profile);
    if (emit.isDone) return;
    result.fold((failure) => _emitFailure(failure, emit), (updated) {
      _identifyProfile(updated);
      emit(ProfileLoadedState(profile: updated));
    });
  }

  Future<void> _updatePhone(
    UserProfile profile,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoadingstate());
    final result = await updateUserPhone(profile);
    if (emit.isDone) return;
    result.fold((failure) => _emitFailure(failure, emit), (updated) {
      _identifyProfile(updated);
      emit(ProfileLoadedState(profile: updated));
    });
  }

  Future<void> _requestDeletion(Emitter<ProfileState> emit) async {
    emit(const ProfileLoadingstate());
    final result = await requestAccountDeletionUsecase(const NoUseCaseParams());
    if (emit.isDone) return;
    result.fold(
      (failure) => _emitFailure(failure, emit),
      (message) => emit(AccountDeletionRequestedState(message: message)),
    );
  }

  Future<void> _requestRecovery(Emitter<ProfileState> emit) async {
    emit(const ProfileLoadingstate());
    final result = await requestAccountRecoveryUsecase(const NoUseCaseParams());
    if (emit.isDone) return;
    result.fold(
      (failure) => _emitFailure(failure, emit),
      (message) => emit(AccountRecoveryRequestedState(message: message)),
    );
  }

  Future<void> _clearCache(Emitter<ProfileState> emit) async {
    final result = await clearCachedProfileUsecase(const NoUseCaseParams());
    if (emit.isDone) return;
    result.fold(
      (failure) => _emitFailure(failure, emit),
      (_) => emit(const ProfileInitialState()),
    );
  }

  void _emitFailure(Failure failure, Emitter<ProfileState> emit) {
    _logger.d(failure.message, error: failure.error);
    emit(ProfileErrorState(message: failure.message));
  }

  void _identifyProfile(UserProfile profile) {
    unawaited(
      analyticsTracker.identify(
        AnalyticsIdentity(
          userId: profile.id,
          hasCompletedOnboarding: profile.onboarded,
        ),
      ),
    );
    unawaited(
      notificationIdentityService.identify(
        NotificationIdentity(
          userId: profile.id,
          email: profile.email,
          displayName: profile.name,
          phoneNumber: profile.phone,
        ),
      ),
    );
  }
}
