import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_scanners_event.dart';
part 'all_scanners_state.dart';

class AllScannersBloc extends Bloc<AllScannersEvent, AllScannersState> {
  final GetAllEventScannersUsecase getAllScanners;

  AllScannersBloc({required this.getAllScanners})
    : super(AllScannersStateInitial()) {
    on<FetchAllScanners>(_onFetchAllScanners);
  }

  Future<void> _onFetchAllScanners(
    FetchAllScanners event,
    Emitter<AllScannersState> emit,
  ) async {
    final currentState = state;

    // Show full-screen loader for first page
    if (event.page == 1) {
      emit(AllScannersStateLoading());
    }
    // Show pagination loader when fetching more
    else if (currentState is AllScannersStateLoaded && event.page > 1) {
      emit(
        AllScannersStatePaginationLoading(
          existingScanners: currentState.scanners,
          hasMore: currentState.hasMore,
        ),
      );
    }
    // Retry after pagination error
    else if (currentState is AllScannersStatePaginationError &&
        event.page > 1) {
      emit(
        AllScannersStatePaginationLoading(
          existingScanners: currentState.existingScanners,
          hasMore: currentState.hasMore,
        ),
      );
    }

    final result = await getAllScanners(
      eventId: event.eventId,
      page: event.page,
      limit: event.limit,
    );

    result.fold(
      (failure) {
        if (currentState is AllScannersStateLoaded && event.page > 1) {
          emit(
            AllScannersStatePaginationError(
              existingScanners: currentState.scanners,
              message: failure.message,
              hasMore: currentState.hasMore,
            ),
          );
        } else if (currentState is AllScannersStatePaginationError &&
            event.page > 1) {
          emit(
            AllScannersStatePaginationError(
              existingScanners: currentState.existingScanners,
              message: failure.message,
              hasMore: currentState.hasMore,
            ),
          );
        } else {
          emit(AllScannersStateError(failure.message));
        }
      },
      (paginatedData) {
        if (currentState is AllScannersStateLoaded && event.page > 1) {
          emit(
            AllScannersStateLoaded(
              scanners: [...currentState.scanners, ...paginatedData.results],
              hasMore: paginatedData.hasMore,
            ),
          );
        } else {
          emit(
            AllScannersStateLoaded(
              scanners: paginatedData.results,
              hasMore: paginatedData.hasMore,
            ),
          );
        }
      },
    );
  }
}


