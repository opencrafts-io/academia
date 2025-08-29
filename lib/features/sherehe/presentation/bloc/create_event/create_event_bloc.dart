import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/domain.dart';
import 'package:academia/core/core.dart';

part 'create_event_event.dart';
part 'create_event_state.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  final CreateEventUseCase createEventUseCase;
  CreateEventBloc({required this.createEventUseCase}) : super(CreateEventInitial()) {
    on<SubmitNewEvent>(_onSubmitNewEvent);
  }

  Future<void> _onSubmitNewEvent(
      SubmitNewEvent event,
      Emitter<CreateEventState> emit,
      ) async {


    emit(CreateEventLoading());
    try {
      final Either<Failure, Unit> result = await createEventUseCase(
        event.event,
        event.imageFile,
        event.bannerImageFile,
        event.cardImageFile,
      );


      result.fold(
            (Failure failure) {
          emit(CreateEventFailure(message: failure.message));
        },
            (Unit _) {
          emit(CreateEventSuccess(event: event.event));
        },
      );
    } catch (e, stackTrace) {
      print('Unexpected error in _onSubmitNewEvent: $e\nStack: $stackTrace');
      emit(CreateEventFailure(
          message: "An unexpected error occurred: ${e.toString()}"));
    }
  }
}