import 'package:academia/features/chirp/common/domain/domain.dart';
import 'package:academia/features/chirp/common/domain/usecases/get_chirp_user_by_id_usecase.dart';
import 'package:academia/features/chirp/common/domain/usecases/get_chirp_user_by_username_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chirp_user_states.dart';

/// ChirpUserCubit
/// For loading chirp user information from all available repositories
/// This cubit is intended to be used in widget level since its a one time 
/// thing. 
class ChirpUserCubit extends Cubit<ChirpUserState> {
  final GetChirpUserByUsernameUsecase getChirpUserByUsernameUsecase;
  final GetChirpUserByIdUsecase getChirpUserByIdUsecase;

  ChirpUserCubit({
    required this.getChirpUserByIdUsecase,
    required this.getChirpUserByUsernameUsecase,
  }) : super(ChirpUserInitialState());

  Future<void> getChirpUserByID(String userID) async {
    final result = await getChirpUserByIdUsecase(userID);

    return result.fold(
      (failure) {
        return emit(ChirpUserErrorState(error: failure.message));
      },
      (chirpUser) {
        return emit(ChirpUserLoadedState(user: chirpUser));
      },
    );
  }

  Future<void> getChirpUserByUsername(String username) async {
    final result = await getChirpUserByUsernameUsecase(username);

    return result.fold(
      (failure) {
        return emit(ChirpUserErrorState(error: failure.message));
      },
      (chirpUser) {
        return emit(ChirpUserLoadedState(user: chirpUser));
      },
    );
  }

}
