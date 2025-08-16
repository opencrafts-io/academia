import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import '../../domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final GetEvent getEvent;
  final GetAttendee getAttendee;
  final CacheEventsUseCase cacheEventsUseCase;

  final Logger _logger = Logger();

  EventBloc({
    required this.getEvent,
    required this.getAttendee,
    required this.cacheEventsUseCase,
  }) : super(EventInitial()) {
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

    // Stop if we’ve reached the end (pagination)
    if (currentState is EventLoaded &&
        event.isLoadMore &&
        currentState.hasReachedEnd) {
      return;
    }

    // Step 1 — Always try cached events first on first load
    if (!event.isLoadMore) {
      final cacheResult = await getEvent.execute();
      cacheResult.fold(
        (failure) {
          _logger.e(
            "Error fetching cached events: ${failure.message}, ${failure.error}",
          );
          // Only emit loading if there is no cached data
          emit(EventLoading());
        },
        (cachedEvents) {
          if (cachedEvents.isNotEmpty) {
            emit(
              EventLoaded(
                events: cachedEvents,
                attendeesMap: {}, // We'll fill after refresh
                hasReachedEnd: false,
                currentPage: 1,
              ),
            );
          } else {
            emit(EventLoading());
          }
        },
      );
    }

    // Step 2 — Fetch from server + update cache
    final freshResult = await cacheEventsUseCase(
      page: nextPage,
      limit: event.limit,
    );

    await freshResult.fold(
      (failure) {
        _logger.e(
          "Error fetching events: ${failure.message}, ${failure.error}",
        );
        // If no current events, show error state
        if (currentState is! EventLoaded || currentState.events.isEmpty) {
          emit(EventError("Error fetching events"));
        }
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
