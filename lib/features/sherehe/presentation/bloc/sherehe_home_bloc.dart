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

    result.fold(
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
      (paginatedData) {
        final newEvents = paginatedData.events;

        if (currentState is EventLoaded && event.page > 1) {
          emit(
            currentState.copyWith( 
              events: [...currentState.events, ...newEvents],
              hasMore: paginatedData.hasMore,
              count: paginatedData.totalEvents,
              nextPage: paginatedData.nextPage,
              previousPage: paginatedData.previousPage,
            ),
          );
        } else {
          emit(
            EventLoaded(
              events: newEvents,
              hasMore: paginatedData.hasMore,
              count: paginatedData.totalEvents,
              nextPage: paginatedData.nextPage,
              previousPage: paginatedData.previousPage,
            ),
          );
        }
      },
    );
  }
}
