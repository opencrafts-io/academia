import 'package:academia/features/features.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magnet/magnet.dart';
import 'package:magnet_daystar_university/magnet_daystar_university.dart';

part 'magnet_state.dart';
part 'magnet_event.dart';

class MagnetBloc extends Bloc<MagnetEvent, MagnetState> {
  final MagnetLoginUsecase magnetLoginUsecase;
  final GetCachedMagnetCredentialUsecase getCachedMagnetCredentialUsecase;

  final Map<int, MagnetPortalRepository> _magnetInstances = {};
  MagnetBloc({
    required this.magnetLoginUsecase,
    required this.getCachedMagnetCredentialUsecase,
  }) : super(MagnetInitialState()) {
    /// Initialize application with the appropriate magnet instance
    /// per institution linked by the institution id
    on<InitializeMagnetInstancesEvent>((event, emit) async {
      try {
        _magnetInstances.addAll({
          5426: await DaystarPortalRepository.create(debugMode: true),
        });
        emit(MagnetInstancesLoadedState());
      } catch (e) {
        emit(MagnetErrorState(error: "Failed to initialize magnet instances"));
      }
    });
    on<GetCachedMagnetCredentialEvent>((event, emit) async {
      emit(MagnetLoadingState());
      final result = await getCachedMagnetCredentialUsecase(
        GetCachedMagnetCredentialUsecaseParams(
          institutionID: event.institutionID,
          userID: event.userID,
        ),
      );
      result.fold(
        (error) {
          emit(MagnetCredentialNotFetched(error: error.message));
        },
        (cred) {
          emit(MagnetCredentialFetched(magnetCredential: cred));
        },
      );
    });

    // on<LinkMagnetAccountEvent>((event, emit) async {
    //   emit(MagnetLoadingState());
    //
    //   if (!_magnetInstances.containsKey(event.institutionID)) {
    //     return emit(MagnetNotSupportedState());
    //   }
    //
    //   final magnetInstance = _magnetInstances[event.institutionID]!;
    //   final result = await magnetLoginUsecase(
    //     MagnetLoginUsecaseParams(
    //       credentials: event.credentials,
    //       magnetInstance: magnetInstance,
    //     ),
    //   );
    //   result.fold(
    //     (error) {
    //       emit(MagnetErrorState(error: error.message));
    //     },
    //     (ok) {
    //       if (!ok) {
    //         emit(
    //           MagnetErrorState(error: "We failed to authenticate your account"),
    //         );
    //       }
    //     },
    //   );
    // });
  }

  bool isInstitutionSupported(int institutionID) {
    final magnetInstance = _magnetInstances[institutionID];
    return magnetInstance != null;
  }
}
