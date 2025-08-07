import 'dart:io';
import 'package:academia/core/error/failures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/domain.dart';

part 'create_event_event.dart';
part 'create_event_state.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  final CreateEventUseCase _createEventUseCase;

  CreateEventBloc({required CreateEventUseCase createEventUseCase})
      : _createEventUseCase = createEventUseCase,
        super(CreateEventInitial()) {
    on<SubmitNewEvent>(_onSubmitNewEvent);
  }

  Future<void> _onSubmitNewEvent(
      SubmitNewEvent event,
      Emitter<CreateEventState> emit,
      ) async {

    if (event.imageFile == null) {
      emit(CreateEventFailure(message: "Event image is required."));
      return;
    }

    emit(CreateEventLoading());
    try {

      final Either<Failure, Unit> result = await _createEventUseCase(
        event.event,
        event.imageFile!,
      );

      result.fold(
            (Failure failure) {
          emit(CreateEventFailure(message: failure.message));
        },
            (Unit _) {
          emit(CreateEventSuccess(event: event.event));
        },
      );
    } catch (e) {
      emit(CreateEventFailure(message: "An unexpected error occurred: ${e.toString()}"));
    }
  }
}
