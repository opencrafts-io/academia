import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/features.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final RefreshCurrentUserProfileUsecase refreshCurrentUserProfileUsecase;
  final UpdateUserProfile updateUserProfile;
  final UpdateUserPhone updateUserPhone;
  final GetCachedProfileUsecase getCachedProfileUsecase;
  final Logger _logger = Logger();

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
          emit(ProfileLoadedState(profile: userProfile));
        },
      );
    });
  }
}
