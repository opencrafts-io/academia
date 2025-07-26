import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final GetEvent getEvent;
  final GetAttendee getAttendee;

  EventBloc({required this.getEvent, required this.getAttendee})
    : super(EventInitial()) {
    on<FetchAllEvents>(_onFetchAllEvents);
  }

  Future<void> _onFetchAllEvents(
    FetchAllEvents event,
    Emitter<EventState> emit,
  ) async {
    emit(EventLoading());

    final eventsResult = await getEvent.execute();
    final attendeesResult = await getAttendee.execute();

    eventsResult.fold((failure) => emit(EventError("Error fetching events")), (
      events,
    ) {
      attendeesResult.fold(
        (failure) => emit(EventError("Error fetching attendees")),
        (attendees) => emit(EventLoaded(events, attendees)),
      );
    });
  }
}
