import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import '../../domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final GetEvent getEvent;
  final GetAttendee getAttendee;
  final Logger _logger = Logger();

  EventBloc({required this.getEvent, required this.getAttendee})
    : super(EventInitial()) {
    on<FetchAllEvents>(_onFetchAllEvents);
  }

  Future<void> _onFetchAllEvents(
    FetchAllEvents event,
    Emitter<EventState> emit,
  ) async {
    final currentState = state;

    // Decide the next page number
    final int nextPage = (currentState is EventLoaded && event.isLoadMore)
        ? currentState.currentPage + 1
        : 1;

    // Stop if we’ve reached the end
    if (currentState is EventLoaded &&
        event.isLoadMore &&
        currentState.hasReachedEnd) {
      return;
    }

    // Reset state when starting fresh load
    if (!event.isLoadMore) emit(EventLoading());

    final eventsResult = await getEvent.execute(
      page: nextPage,
      limit: event.limit,
    );

    await eventsResult.fold(
      (failure) {
        _logger.e(
          "Error fetching events: ${failure.message}, ${failure.error}",
        );
        emit(EventError("Error fetching events"));
      },
      (paginatedEvents) async {
        final List<Event> updatedEvents =
            (currentState is EventLoaded && event.isLoadMore)
            ? [...currentState.events, ...paginatedEvents.events]
            : paginatedEvents.events;

        final attendeesMap = (currentState is EventLoaded && event.isLoadMore)
            ? Map<String, List<Attendee>>.from(currentState.attendeesMap)
            : <String, List<Attendee>>{};

        // Fetch attendees for each event
        for (final ev in paginatedEvents.events) {
          final attendeeResult = await getAttendee.execute(
            eventId: ev.id,
            page: 1,
            limit: 4,
          );

          attendeeResult.fold(
            (_) => attendeesMap[ev.id] = [],
            (attendees) => attendeesMap[ev.id] = attendees,
          );
        }

        emit(
          EventLoaded(
            events: updatedEvents,
            attendeesMap: attendeesMap,
            hasReachedEnd: paginatedEvents.nextPage == null,
            currentPage: nextPage,
          ),
        );
      },
    );
  }
}
