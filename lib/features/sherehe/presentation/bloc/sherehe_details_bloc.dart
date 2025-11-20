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

    // Handle event details result
    if (eventResult.isLeft()) {
      final failure = eventResult.swap().getOrElse(() => throw '');
      emit(ShereheDetailsError(message: failure.message));
      return;
    }

    final eventData = eventResult.getOrElse(() => throw '');
    emit(
      ShereheDetailsLoaded(
        event: eventData,
        attendees: const [],
        isLoadingAttendees: true,
      ),
    );

    // Load attendees
    final attendeeResult = await getAttendeesUseCase.execute(
      eventId: event.eventId,
      page: 1,
      limit: 3,
    );

    attendeeResult.fold(
      (failure) {
        emit(
          ShereheDetailsLoaded(
            event: eventData,
            attendees: const [],
            isUserAttending: false,
            isLoadingAttendees: false,
            attendeeErrorMessage: failure.message,
          ),
        );
      },
      (attendeeList) {
        emit(
          ShereheDetailsLoaded(
            event: eventData,
            attendees: attendeeList.results,
            isUserAttending: false,
            isLoadingAttendees: false,
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
