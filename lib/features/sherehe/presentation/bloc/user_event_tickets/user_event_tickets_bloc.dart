import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event_tickets_event.dart';
part 'user_event_tickets_state.dart';

class UserEventTicketsBloc
    extends Bloc<UserEventTicketsEvent, UserEventTicketsState> {
  final GetUserPurchasedTicketsUseCase getUserTicketsForEvent;

  UserEventTicketsBloc({required this.getUserTicketsForEvent})
    : super(UserEventTicketInitial()) {
    on<FetchUserEventTickets>(_onFetchUserEventTickets);
  }

  Future<void> _onFetchUserEventTickets(
    FetchUserEventTickets event,
    Emitter<UserEventTicketsState> emit,
  ) async {
    final currentState = state;

    // Show full-screen loader for first page
    if (event.page == 1) {
      emit(UserEventTicketLoading());
    }
    // Show pagination loader when fetching more
    else if (currentState is UserEventTicketLoaded && event.page > 1) {
      emit(
        UserEventTicketPaginationLoading(
          existingAttendee: currentState.attendee,
          hasMore: currentState.hasMore,
        ),
      );
    }
    // Retry after pagination error
    else if (currentState is UserEventTicketPaginationError && event.page > 1) {
      emit(
        UserEventTicketPaginationLoading(
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
        if (currentState is UserEventTicketLoaded && event.page > 1) {
          emit(
            UserEventTicketPaginationError(
              existingAttendee: currentState.attendee,
              message: failure.message,
              hasMore: currentState.hasMore,
            ),
          );
        } else if (currentState is UserEventTicketPaginationError && event.page > 1) {
          // Retry after pagination error failed again
          emit(
            UserEventTicketPaginationError(
              existingAttendee: currentState.existingAttendee,
              message: failure.message,
              hasMore: currentState.hasMore,
            ),
          );
        } else {
          // First load failed
          emit(UserEventTicketError(failure.message));
        }
      },
      (paginatedData) {
        // Append or replace posts depending on the page
        if (currentState is UserEventTicketLoaded && event.page > 1) {
          emit(
            UserEventTicketLoaded(
              attendee: [...currentState.attendee, ...paginatedData.results],
              hasMore: paginatedData.hasMore,
            ),
          );
        } else {
          emit(
            UserEventTicketLoaded(
              attendee: paginatedData.results,
              hasMore: paginatedData.hasMore,
            ),
          );
        }
      },
    );
  }
}
