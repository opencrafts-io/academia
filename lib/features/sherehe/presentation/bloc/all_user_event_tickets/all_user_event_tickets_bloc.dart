import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_user_event_tickets_event.dart';
part 'all_user_event_tickets_state.dart';

class AllUserEventTicketsBloc
    extends Bloc<AllUserEventTicketsEvent, AllUserEventTicketsState> {
  final GetAllUserPurchasedTicketsUseCase getUserTicketsForEvent;
  final SearchUserAttendedEventsUseCase searchUserAttendedEvents;

  AllUserEventTicketsBloc({
    required this.getUserTicketsForEvent,
    required this.searchUserAttendedEvents,
  }) : super(UserAllTicketsInitial()) {
    on<FetchAllUserTickets>(_onFetchAllUserTickets);
    on<SearchUserAttendedEvents>(_onSearchUserEventTickets);
  }

  Future<void> _onFetchAllUserTickets(
    FetchAllUserTickets event,
    Emitter<AllUserEventTicketsState> emit,
  ) async {
    final currentState = state;

    // Show full-screen loader for first page
    if (event.page == 1) {
      emit(UserAllTicketsLoading());
    }
    // Show pagination loader when fetching more
    else if (currentState is UserAllTicketsLoaded && event.page > 1) {
      emit(
        UserAllTicketsPaginationLoading(
          existingAttendee: currentState.attendee,
          hasMore: currentState.hasMore,
        ),
      );
    }
    // Retry after pagination error
    else if (currentState is UserAllTicketsPaginationError && event.page > 1) {
      emit(
        UserAllTicketsPaginationLoading(
          existingAttendee: currentState.existingAttendee,
          hasMore: currentState.hasMore,
        ),
      );
    }

    final result = await getUserTicketsForEvent(
      page: event.page,
      limit: event.limit,
    );

    result.fold(
      (failure) {
        // Pagination failed, keep previous posts visible
        if (currentState is UserAllTicketsLoaded && event.page > 1) {
          emit(
            UserAllTicketsPaginationError(
              existingAttendee: currentState.attendee,
              message: failure.message,
              hasMore: currentState.hasMore,
            ),
          );
        } else if (currentState is UserAllTicketsPaginationError &&
            event.page > 1) {
          // Retry after pagination error failed again
          emit(
            UserAllTicketsPaginationError(
              existingAttendee: currentState.existingAttendee,
              message: failure.message,
              hasMore: currentState.hasMore,
            ),
          );
        } else {
          // First load failed
          emit(UserAllTicketsError(failure.message));
        }
      },
      (paginatedData) {
        // Append or replace posts depending on the page
        if (currentState is UserAllTicketsLoaded && event.page > 1) {
          emit(
            UserAllTicketsLoaded(
              attendee: [...currentState.attendee, ...paginatedData.results],
              hasMore: paginatedData.hasMore,
            ),
          );
        } else {
          emit(
            UserAllTicketsLoaded(
              attendee: paginatedData.results,
              hasMore: paginatedData.hasMore,
            ),
          );
        }
      },
    );
  }

  Future<void> _onSearchUserEventTickets(
    SearchUserAttendedEvents event,
    Emitter<AllUserEventTicketsState> emit,
  ) async {
    emit(UserAllAttendedEventsSearchLoading());

    final result = await searchUserAttendedEvents(query: event.query);

    result.fold(
      (failure) {
        emit(UserAllAttendedEventsSearchError(failure.message));
      },
      (attendees) {
        emit(UserAllAttendedEventsLoaded(attendee: attendees));
      },
    );
  }
}
