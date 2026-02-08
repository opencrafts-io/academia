import 'package:academia/config/config.dart';
import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/features.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:academia/injection_container.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final RefreshCurrentUserProfileUsecase refreshCurrentUserProfileUsecase;
  final UpdateUserProfile updateUserProfile;
  final UpdateUserPhone updateUserPhone;
  final GetCachedProfileUsecase getCachedProfileUsecase;
  final Logger _logger = Logger();
  final Posthog posthog = Posthog();

  ProfileBloc({
    required this.refreshCurrentUserProfileUsecase,
    required this.updateUserProfile,
    required this.getCachedProfileUsecase,
    required this.updateUserPhone,
  }) : super(ProfileInitialState()) {
    on<RefreshProfileEvent>((event, emit) async {
      final result = await refreshCurrentUserProfileUsecase(NoParams());
      result.fold(
        (failure) {
          _logger.d(failure.message, error: failure.error);
          emit(ProfileErrorState(message: failure.message));
        },
        (userProfile) {
          emit(ProfileLoadedState(profile: userProfile));
        },
      );
    });

    on<GetCachedProfileEvent>((event, emit) async {
      final result = await getCachedProfileUsecase(NoParams());
      result.fold(
        (failure) {
          _logger.d(failure.message, error: failure.error);
          emit(ProfileErrorState(message: failure.message));
        },
        (userProfile) {
          if (sl<FlavorConfig>().isProduction) {
            posthog.identify(
              userId: userProfile.id,
              userProperties: {
                "email": userProfile.email,
                "name": userProfile.name,
                "onboarded": userProfile.onboarded,
                "terms_accepted": userProfile.termsAccepted,
                "phone": userProfile.phone ?? "not yet set",
              },
              userPropertiesSetOnce: {
                "joined_at": userProfile.createdAt.toString(),
              },
            );
          }
          emit(ProfileLoadedState(profile: userProfile));
        },
      );
    });

    on<UpdateUserProfileEvent>((event, emit) async {
      final result = await updateUserProfile(event.profile);
      result.fold(
        (failure) {
          _logger.d(failure.message, error: failure.error);
          emit(ProfileErrorState(message: failure.message));
        },
        (userProfile) {
          if (sl<FlavorConfig>().isProduction) {
            posthog.identify(
              userId: userProfile.id,
              userProperties: {
                "email": userProfile.email,
                "name": userProfile.name,
                "onboarded": userProfile.onboarded,
                "terms_accepted": userProfile.termsAccepted,
              },
              userPropertiesSetOnce: {
                "joined_at": userProfile.createdAt.toString(),
                "phone": userProfile.phone ?? "not yet set",
              },
            );
          }

          emit(ProfileLoadedState(profile: userProfile));
        },
      );
    });

    on<UpdateUserPhoneEvent>((event, emit) async {
      final result = await updateUserPhone(event.profile);
      result.fold(
        (failure) {
          _logger.d(failure.message, error: failure.error);
          emit(ProfileErrorState(message: failure.message));
        },
        (userProfile) {
          if (sl<FlavorConfig>().isProduction) {
            posthog.identify(
              userId: userProfile.id,
              userProperties: {
                "email": userProfile.email,
                "name": userProfile.name,
                "onboarded": userProfile.onboarded,
                "terms_accepted": userProfile.termsAccepted,
                "phone": userProfile.phone ?? "not yet set",
              },
              userPropertiesSetOnce: {
                "joined_at": userProfile.createdAt.toString(),
              },
            );
          }

          emit(ProfileLoadedState(profile: userProfile));
        },
      );
    });
  }
}
