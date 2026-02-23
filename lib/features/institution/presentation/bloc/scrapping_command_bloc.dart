import 'package:academia/core/error/failures.dart';
import 'package:academia/features/institution/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magnet/magnet.dart';

part 'scrapping_command_event.dart';
part 'scrapping_command_state.dart';

class ScrappingCommandBloc
    extends Bloc<ScrappingCommandEvent, ScrappingCommandState> {
  final GetInstitutionScrappingCommandUsecase
  getInstitutionScrappingCommandUsecase;

  ScrappingCommandBloc({required this.getInstitutionScrappingCommandUsecase})
    : super(const ScrappingCommandInitial()) {
    on<GetScrappingCommandEvent>(_onGetScrappingCommand);
  }

  Future<void> _onGetScrappingCommand(
    GetScrappingCommandEvent event,
    Emitter<ScrappingCommandState> emit,
  ) async {
    emit(const ScrappingCommandLoading());

    await emit.forEach(
      getInstitutionScrappingCommandUsecase(event.institutionID),
      onData: (Either<Failure, ScrappingCommand?> either) {
        return either.fold(
          (failure) =>
              ScrappingCommandError(message: failure.message, command: null),
          (command) => ScrappingCommandLoaded(command: command),
        );
      },
      onError: (error, stackTrace) {
        return ScrappingCommandError(
          message: 'Unexpected error: $error',
          command: null,
        );
      },
    );
  }
}
