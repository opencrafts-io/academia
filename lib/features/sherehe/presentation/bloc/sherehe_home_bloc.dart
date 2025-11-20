import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'sherehe_home_event.dart';
part 'sherehe_home_state.dart';

class ShereheHomeBloc extends Bloc<ShereheHomeEvent, ShereheHomeState> {
  final GetEvent getEvent;
  final GetAttendee getAttendee;
  final CacheEventsUseCase cacheEventsUseCase;

  ShereheHomeBloc({
    required this.getEvent,
    required this.getAttendee,
    required this.cacheEventsUseCase,
  }) : super(EventInitial()) {
    on<FetchAllEvents>(_onFetchAllEvents);
    // on<FetchEventAttendees>(_onFetchEventAttendees);
  }

  Future<void> _onFetchAllEvents(
    FetchAllEvents event,
    Emitter<ShereheHomeState> emit,
  ) async {
    final currentState = state;

    // Handle initial load vs pagination load
    if (event.page == 1 && !event.isLoadMore) {
      emit(EventLoading());
    } else if (currentState is EventLoaded && event.page > 1) {
      emit(
        EventsPaginationLoading(
          existingEvents: currentState.events,
          hasMore: currentState.hasMore,
        ),
      );
    } else if (currentState is EventsPaginationError && event.page > 1) {
      emit(
        EventsPaginationLoading(
          existingEvents: currentState.existingEvents,
          hasMore: currentState.hasMore,
        ),
      );
    }

    final result = await getEvent.execute(page: event.page, limit: event.limit);

    await result.fold(
      (failure) {
        if (currentState is EventLoaded && event.page > 1) {
          emit(
            EventsPaginationError(
              existingEvents: currentState.events,
              message: failure.message,
              hasMore: currentState.hasMore,
            ),
          );
        } else if (currentState is EventsPaginationError && event.page > 1) {
          emit(
            EventsPaginationError(
              existingEvents: currentState.existingEvents,
              message: failure.message,
              hasMore: currentState.hasMore,
            ),
          );
        } else {
          emit(EventsError(message: failure.message));
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
            (attendees) => attendeesMap[ev.id] = attendees.results,
          );
        }

        emit(
          EventLoaded(
            events: updatedEvents,
            attendeesMap: attendeesMap,
            hasMore: paginatedEvents.nextPage != null,
            nextPage: paginatedEvents.nextPage,
            count: paginatedEvents.totalEvents,
          ),
        );
      },
    );
  }

  // Future<void> _onFetchEventAttendees(
  //   FetchEventAttendees event,
  //   Emitter<ShereheHomeState> emit,
  // ) async {
  //   final current = state as EventLoaded;

  //   // Mark only this event as loading
  //   emit(
  //     current.copyWith(
  //       attendeesMap: {
  //         ...current.attendeesMap,
  //         event.event.id: current.attendeesMap[event.event.id] ?? [],
  //       },
  //       attendeesLoadingMap: {
  //         ...current.attendeesLoadingMap,
  //         event.event.id: true,
  //       },
  //     ),
  //   );

  //   final result = await getAttendee.execute(
  //     eventId: event.event.id,
  //     page: 1,
  //     limit: 4,
  //   );

  //   result.fold(
  //     (_) {
  //       emit(
  //         current.copyWith(
  //           attendeesLoadingMap: {
  //             ...current.attendeesLoadingMap,
  //             event.event.id: false,
  //           },
  //           attendeesErrorMap: {
  //             ...current.attendeesErrorMap,
  //             event.event.id: true,
  //           },
  //         ),
  //       );
  //     },
  //     (attendees) {
  //       emit(
  //         current.copyWith(
  //           attendeesLoadingMap: {
  //             ...current.attendeesLoadingMap,
  //             event.event.id: false,
  //           },
  //           attendeesMap: {
  //             ...current.attendeesMap,
  //             event.event.id: attendees.results,
  //           },
  //           attendeesErrorMap: {
  //             ...current.attendeesErrorMap,
  //             event.event.id: false,
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }
}
