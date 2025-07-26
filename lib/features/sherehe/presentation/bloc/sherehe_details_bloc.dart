import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/domain.dart';
import 'package:academia/core/core.dart';

part 'sherehe_details_event.dart';
part 'sherehe_details_state.dart';

class ShereheDetailsBloc extends Bloc<ShereheDetailsEvent, ShereheDetailsState> {
  final GetSpecificEvent getSpecificEventUseCase;
  final GetAttendee getAttendeesUseCase; // Gets all attendees based on data layer

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
    final attendeesResult = await getAttendeesUseCase.execute();

    eventResult.fold(
          (eventFailure) {
        String errorMessage;
        if (eventFailure is ServerFailure) {
          errorMessage = eventFailure.message ?? 'Server error. Please try again later.';
        } else if (eventFailure is CacheFailure) {
          errorMessage = eventFailure.message ?? 'Cache error. Please try again.';
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
              errorMessage = attendeeFailure.message ?? 'Failed to load attendee list.';
            } else if (attendeeFailure is CacheFailure) {
              errorMessage = attendeeFailure.message ?? 'Cache error for attendee list.';
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