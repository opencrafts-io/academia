import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/features.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final RefreshCurrentUserProfileUsecase refreshCurrentUserProfileUsecase;
  final Logger _logger = Logger();

  ProfileBloc({required this.refreshCurrentUserProfileUsecase})
    : super(ProfileInitialState()) {
    on<RefreshProfileEvent>((event, emit) async {
      final result = await refreshCurrentUserProfileUsecase(NoParams());
      result.fold(
        (failure) {
          _logger.d(failure.message);
          _logger.d(failure.error);
          emit(ProfileErrorState(message: failure.message));
        },
        (userProfile) {
          emit(ProfileLoadedState(profile: userProfile));
        },
      );
    });
  }
}
