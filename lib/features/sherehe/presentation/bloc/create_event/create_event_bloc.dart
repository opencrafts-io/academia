import 'dart:io';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:academia/core/core.dart';

part 'create_event_event.dart';
part 'create_event_state.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  final CreateEventUseCase createEventUseCase;
  CreateEventBloc({required this.createEventUseCase})
    : super(CreateEventInitial()) {
    on<SubmitNewEvent>(_onSubmitNewEvent);
  }

  Future<void> _onSubmitNewEvent(
    SubmitNewEvent event,
    Emitter<CreateEventState> emit,
  ) async {
    emit(CreateEventLoading());

    final result = await createEventUseCase(
      eventName: event.eventName,
      eventDescription: event.eventDescription,
      eventLocation: event.eventLocation,
      eventDate: event.eventDate,
      organizerId: event.organizerId,
      eventGenre: event.eventGenre,
      eventCardImage: event.eventCardImage,
      eventPosterImage: event.eventPosterImage,
      eventBannerImage: event.eventBannerImage,
      tickets: event.tickets,
      selectedPaymentType: event.selectedPaymentType,
      paybillNumber: event.paybillNumber,
      accountReference: event.accountReference,
      tillNumber: event.tillNumber,
      sendMoneyPhoneNumber: event.sendMoneyPhoneNumber,
    );

    result.fold(
      (Failure failure) {
        emit(CreateEventFailure(message: failure.message));
      },
      (createdEvent) {
        emit(CreateEventSuccess(createdEvent));
      },
    );
  }
}
