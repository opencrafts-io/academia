import 'package:academia/core/error/failures.dart';
import 'package:academia/features/institution/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magnet/magnet.dart';

import 'scrapping_command_state.dart';
export 'scrapping_command_state.dart';

part 'scrapping_command_event.dart';

class ScrappingCommandBloc
    extends Bloc<ScrappingCommandEvent, ScrappingCommandState> {
  final GetInstitutionScrappingCommandUsecase
  getInstitutionScrappingCommandUsecase;

  ScrappingCommandBloc({required this.getInstitutionScrappingCommandUsecase})
    : super(const ScrappingCommandState.initial()) {
    on<GetScrappingCommandEvent>(_onGetScrappingCommand);
  }

  Future<void> _onGetScrappingCommand(
    GetScrappingCommandEvent event,
    Emitter<ScrappingCommandState> emit,
  ) async {
    emit(const ScrappingCommandState.loading());

    await emit.forEach(
      getInstitutionScrappingCommandUsecase(event.institutionID),
      onData: (Either<Failure, ScrappingCommand?> either) {
        return either.fold(
          (failure) => ScrappingCommandState.error(
            message: failure.message,
            command: null,
          ),
          (command) => ScrappingCommandState.loaded(command),
        );
      },
      onError: (error, stackTrace) {
        return ScrappingCommandState.error(
          message: 'Unexpected error: $error',
          command: null,
        );
      },
    );
  }
}
