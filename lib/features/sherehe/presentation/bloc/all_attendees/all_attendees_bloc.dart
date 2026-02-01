import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_attendees_event.dart';
part 'all_attendees_state.dart';

class AllAttendeesBloc extends Bloc<AllAttendeesEvent, AllAttendeesState> {
  final GetAllAttendees getAllAttendees;

  AllAttendeesBloc({required this.getAllAttendees})
    : super(AllAttendeesStateInitial()) {
    on<FetchAllAttendees>(_onFetchAllAttendees);
  }

  Future<void> _onFetchAllAttendees(
    FetchAllAttendees event,
    Emitter<AllAttendeesState> emit,
  ) async {
    final currentState = state;

    // Show full-screen loader for first page
    if (event.page == 1) {
      emit(AllAttendeesStateLoading());
    }
    // Show pagination loader when fetching more
    else if (currentState is AllAttendeesStateLoaded && event.page > 1) {
      emit(
        AllAttendeesStatePaginationLoading(
          existingAttendee: currentState.attendees,
          hasMore: currentState.hasMore,
        ),
      );
    }
    // Retry after pagination error
    else if (currentState is AllAttendeesStatePaginationError &&
        event.page > 1) {
      emit(
        AllAttendeesStatePaginationLoading(
          existingAttendee: currentState.existingAttendee,
          hasMore: currentState.hasMore,
        ),
      );
    }

    final result = await getAllAttendees(
      eventId: event.eventId,
      page: event.page,
      limit: event.limit,
    );

    result.fold(
      (failure) {
        if (currentState is AllAttendeesStateLoaded && event.page > 1) {
          emit(
            AllAttendeesStatePaginationError(
              existingAttendee: currentState.attendees,
              message: failure.message,
              hasMore: currentState.hasMore,
            ),
          );
        } else if (currentState is AllAttendeesStatePaginationError &&
            event.page > 1) {
          emit(
            AllAttendeesStatePaginationError(
              existingAttendee: currentState.existingAttendee,
              message: failure.message,
              hasMore: currentState.hasMore,
            ),
          );
        } else {
          emit(AllAttendeesStateError(failure.message));
        }
      },
      (paginatedData) {
        if (currentState is AllAttendeesStateLoaded && event.page > 1) {
          emit(
            AllAttendeesStateLoaded(
              attendees: [...currentState.attendees, ...paginatedData.results],
              hasMore: paginatedData.hasMore,
            ),
          );
        } else {
          emit(
            AllAttendeesStateLoaded(
              attendees: paginatedData.results,
              hasMore: paginatedData.hasMore,
            ),
          );
        }
      },
    );
  }
}
