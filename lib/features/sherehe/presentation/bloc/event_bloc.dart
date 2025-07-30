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

    final eventsResult = await getEvent.execute(
      page: event.page,
      limit: event.limit,
    );

    await eventsResult.fold(
      (failure) async => emit(EventError("Error fetching events")),
      (events) async {
        // First emit events without attendees for immediate display
        emit(EventLoaded(events, {}));

        // Then load attendees progressively
        final Map<String, List<Attendee>> attendeesMap = {};

        for (final ev in events) {
          final result = await getAttendee.execute(
            eventId: ev.id,
            page: 1,
            limit: 4,
          );

          result.fold(
            (failure) => attendeesMap[ev.id] = [],
            (attendees) => attendeesMap[ev.id] = attendees,
          );

          // Emit updated state with new attendees
          emit(EventLoaded(events, Map.from(attendeesMap)));
        }
      },
    );
  }
}
