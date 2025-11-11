import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'sherehe_details_event.dart';
part 'sherehe_details_state.dart';

class ShereheDetailsBloc
    extends Bloc<ShereheDetailsEvent, ShereheDetailsState> {
  final GetSpecificEvent getSpecificEventUseCase;
  final GetAttendee getAttendeesUseCase;
  final CreateAttendeeUseCase createAttendeeUseCase;

  ShereheDetailsBloc({
    required this.getSpecificEventUseCase,
    required this.getAttendeesUseCase,
    required this.createAttendeeUseCase,
  }) : super(ShereheDetailsInitial()) {
    on<LoadShereheDetails>(_onLoadShereheDetails);
    on<MarkAsGoing>(_onMarkAsGoing);
  }

  Future<void> _onLoadShereheDetails(
    LoadShereheDetails event,
    Emitter<ShereheDetailsState> emit,
  ) async {
    emit(ShereheDetailsLoading());

    final eventResult = await getSpecificEventUseCase.execute(
      eventId: event.eventId,
    );

    eventResult.fold(
      (failure) => emit(ShereheDetailsError(message: failure.message)),
      (eventData) async {
        emit(
          ShereheDetailsLoaded(
            event: eventData,
            attendees: const [],
            isLoadingAttendees: true,
          ),
        );

        final attendeeResult = await getAttendeesUseCase.execute(
          eventId: event.eventId,
        );
        attendeeResult.fold(
          (failure) => emit(
            ShereheDetailsLoaded(
              event: eventData,
              attendees: const [],
              isUserAttending: false,
              isLoadingAttendees: false,
              attendeeErrorMessage: failure.message,
            ),
          ),
          (attendeeList) => emit(
            ShereheDetailsLoaded(
              event: eventData,
              attendees: attendeeList,
              isUserAttending: false, //to be determined later
              isLoadingAttendees: false,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onMarkAsGoing(
    MarkAsGoing event,
    Emitter<ShereheDetailsState> emit,
  ) async {
    final currentState = state;

    if (currentState is! ShereheDetailsLoaded) return;

    emit(
      MarkingAsGoing(
        event: currentState.event,
        attendees: currentState.attendees,
        isUserAttending: currentState.isUserAttending,
      ),
    );

    final result = await createAttendeeUseCase.call(
      userId: event.userId,
      eventId: event.eventId,
    );

    await result.fold(
      (failure) {
        emit(
          MarkedAsGoingFailure(
            event: currentState.event,
            attendees: currentState.attendees,
            isUserAttending: currentState.isUserAttending,
            message: failure.message,
          ),
        );
      },
      (newAttendee) async {
        final updatedAttendees = List<Attendee>.from(currentState.attendees)
          ..add(newAttendee);

        emit(
          ShereheDetailsLoaded(
            event: currentState.event,
            attendees: updatedAttendees,
            isUserAttending: true,
            showConfettiEffect: true,
          ),
        );
      },
    );
  }
}
