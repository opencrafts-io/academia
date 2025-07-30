import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/domain.dart';
import 'package:academia/core/core.dart';

part 'sherehe_details_event.dart';
part 'sherehe_details_state.dart';

class ShereheDetailsBloc extends Bloc<ShereheDetailsEvent, ShereheDetailsState> {
  final GetSpecificEvent getSpecificEventUseCase;
  final GetAttendee getAttendeesUseCase;

  ShereheDetailsBloc({
    required this.getSpecificEventUseCase,
    required this.getAttendeesUseCase,
  }) : super(ShereheDetailsInitial()) {
    on<LoadShereheDetails>(_onLoadShereheDetails);
  }

  Future<void> _onLoadShereheDetails(
      LoadShereheDetails event,
      Emitter<ShereheDetailsState> emit,
      ) async {
    emit(ShereheDetailsLoading());

    // Execute use cases concurrently
    final eventResult = await getSpecificEventUseCase.execute(event.eventId);
    final attendeesResult = await getAttendeesUseCase.execute(eventId: event.eventId, page: 1, limit: 4);

    eventResult.fold(
          (eventFailure) {
        String errorMessage;
        if (eventFailure is ServerFailure) {
          errorMessage = eventFailure.message;
        } else if (eventFailure is CacheFailure) {
          errorMessage = eventFailure.message;
        } else {
          errorMessage = 'An unexpected error occurred.';
        }
        emit(ShereheDetailsError(message: errorMessage));
      },
          (event) {
        attendeesResult.fold(
              (attendeeFailure) {
            String errorMessage;
            if (attendeeFailure is ServerFailure) {
              errorMessage = attendeeFailure.message;
            } else if (attendeeFailure is CacheFailure) {
              errorMessage = attendeeFailure.message;
            } else {
              errorMessage = 'An unexpected error occurred while loading attendees.';
            }
            emit(ShereheDetailsError(message: errorMessage));
          },
              (allAttendees) {
            emit(ShereheDetailsLoaded(event: event, attendees: allAttendees));
          },
        );
      },
    );
  }
}