import 'package:academia/core/error/failures.dart';
import 'package:academia/features/institution/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'institution_key_state.dart';
export 'institution_key_state.dart';

part 'institution_key_event.dart';

class InstitutionKeyBloc
    extends Bloc<InstitutionKeyEvent, InstitutionKeyState> {
  final GetInstitutionKeyUsecase getInstitutionKeyUsecase;
  final SaveInstitutionKeyUsecase saveInstitutionKeyUsecase;

  InstitutionKeyBloc({
    required this.getInstitutionKeyUsecase,
    required this.saveInstitutionKeyUsecase,
  }) : super(const InstitutionKeyState.initial()) {
    on<GetInstitutionKeyEvent>(_onGetInstitutionKey);
    on<SaveInstitutionKeyEvent>(_onSaveInstitutionKey);
  }

  /// Watches the key for a specific institution
  Future<void> _onGetInstitutionKey(
    GetInstitutionKeyEvent event,
    Emitter<InstitutionKeyState> emit,
  ) async {
    emit(const InstitutionKeyState.loading());

    await emit.forEach(
      getInstitutionKeyUsecase(event.institutionID),
      onData: (Either<Failure, InstitutionKey?> either) {
        return either.fold(
          (failure) =>
              InstitutionKeyState.error(message: failure.message, key: null),
          (key) => InstitutionKeyState.loaded(key),
        );
      },
      onError: (error, stackTrace) {
        return InstitutionKeyState.error(
          message: 'Unexpected error: $error',
          key: null,
        );
      },
    );
  }

  /// Saves the provided institution key
  Future<void> _onSaveInstitutionKey(
    SaveInstitutionKeyEvent event,
    Emitter<InstitutionKeyState> emit,
  ) async {
    emit(const InstitutionKeyState.loading());

    final result = await saveInstitutionKeyUsecase(event.key);

    result.fold(
      (failure) => emit(
        InstitutionKeyState.error(message: failure.message, key: event.key),
      ),
      (_) => emit(InstitutionKeyState.loaded(event.key)),
    );
  }
}
