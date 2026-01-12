import 'package:academia/database/database.dart';
import 'package:academia/features/streaks/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'activities_event.dart';
part 'activities_state.dart';

class ActivitiesBloc extends Bloc<ActivitiesEvent, ActivitiesState> {
  final GetStreakActivities getStreakActivities;
  static const int _pageSize = 20;

  ActivitiesBloc({required this.getStreakActivities}) : super(ActivitiesInitial()) {
    on<LoadActivities>(_onLoadActivities);
    on<LoadMoreActivities>(_onLoadMoreActivities);
    on<RefreshActivities>(_onRefreshActivities);
  }

  Future<void> _onLoadActivities(
    LoadActivities event,
    Emitter<ActivitiesState> emit,
  ) async {
    emit(ActivitiesLoading());

    final result = await getStreakActivities(
      GetStreakActivitiesParams(
        page: 1,
        pageSize: _pageSize,
        forceRefresh: false,
      ),
    );

    result.fold(
      (failure) => emit(ActivitiesError(message: failure.message)),
      (paginated) => emit(
        ActivitiesLoaded(
          activities: paginated.entries,
          totalCount: paginated.totalCount,
          hasMore: paginated.hasNext,
          currentPage: 1,
        ),
      ),
    );
  }

  Future<void> _onLoadMoreActivities(
    LoadMoreActivities event,
    Emitter<ActivitiesState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ActivitiesLoaded || !currentState.hasMore) return;

    emit(
      ActivitiesLoadingMore(
        activities: currentState.activities,
        totalCount: currentState.totalCount,
        hasMore: currentState.hasMore,
        currentPage: currentState.currentPage,
      ),
    );

    final nextPage = currentState.currentPage + 1;
    final result = await getStreakActivities(
      GetStreakActivitiesParams(
        page: nextPage,
        pageSize: _pageSize,
        forceRefresh: false,
      ),
    );

    result.fold(
      (failure) => emit(currentState), // Revert to previous state
      (paginated) => emit(
        ActivitiesLoaded(
          activities: [...currentState.activities, ...paginated.entries],
          totalCount: paginated.totalCount,
          hasMore: paginated.hasNext,
          currentPage: nextPage,
        ),
      ),
    );
  }

  Future<void> _onRefreshActivities(
    RefreshActivities event,
    Emitter<ActivitiesState> emit,
  ) async {
    // Keep current state while refreshing
    final result = await getStreakActivities(
      GetStreakActivitiesParams(
        page: 1,
        pageSize: _pageSize,
        forceRefresh: true,
      ),
    );

    result.fold(
      (failure) {
        if (state is ActivitiesLoaded) {
          // Keep showing current data on refresh error
        } else {
          emit(const ActivitiesError(message: 'Failed to refresh'));
        }
      },
      (paginated) => emit(
        ActivitiesLoaded(
          activities: paginated.entries,
          totalCount: paginated.totalCount,
          hasMore: paginated.hasNext,
          currentPage: 1,
        ),
      ),
    );
  }
}
