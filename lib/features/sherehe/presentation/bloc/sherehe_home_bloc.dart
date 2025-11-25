import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'sherehe_home_event.dart';
part 'sherehe_home_state.dart';

class ShereheHomeBloc extends Bloc<ShereheHomeEvent, ShereheHomeState> {
  final GetEvent getEvent;

  ShereheHomeBloc({required this.getEvent}) : super(EventInitial()) {
    on<FetchAllEvents>(_onFetchAllEvents);
  }

  Future<void> _onFetchAllEvents(
    FetchAllEvents event,
    Emitter<ShereheHomeState> emit,
  ) async {
    final currentState = state;

    if (event.page == 1 && !event.isLoadMore) {
      emit(EventLoading());
    } else if (currentState is EventLoaded && event.page > 1) {
      emit(
        EventsPaginationLoading(
          existingEvents: currentState.events,
          hasMore: currentState.hasMore,
        ),
      );
    } // Retry after pagination error
    else if (currentState is EventsPaginationError && event.page > 1) {
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
        } else {
          emit(EventsError(message: failure.message));
        }
      },
      (paginatedEvents) async {
        final List<Event> updatedEvents =
            (currentState is EventLoaded && event.isLoadMore)
            ? [...currentState.events, ...paginatedEvents.events]
            : paginatedEvents.events;

        emit(
          EventLoaded(
            events: updatedEvents,
            hasMore: paginatedEvents.nextPage != null,
            nextPage: paginatedEvents.nextPage,
            count: paginatedEvents.totalEvents,
          ),
        );
      },
    );
  }
}
