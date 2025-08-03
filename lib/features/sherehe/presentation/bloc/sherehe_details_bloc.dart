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

    final eventResult = await getSpecificEventUseCase.execute(event.eventId);

    await eventResult.fold(
          (eventFailure) async {
        String errorMessage = 'An unexpected error occurred.';
        if (eventFailure is ServerFailure) {
          errorMessage = eventFailure.message;
        } else if (eventFailure is CacheFailure) {
          errorMessage = eventFailure.message;
        }
        emit(ShereheDetailsError(message: errorMessage));
      },
          (event) async {
        final attendeesResult = await getAttendeesUseCase.execute(
          eventId: event.id,
          page: 1,
          limit: 4,
        );

        List<Attendee> attendees = [];

        await attendeesResult.fold(
              (attendeeFailure) async {
          },
              (fetchedAttendees) async {
            attendees = fetchedAttendees;
          },
        );

        emit(ShereheDetailsLoaded(event: event, attendees: attendees));
      },
    );
  }
}