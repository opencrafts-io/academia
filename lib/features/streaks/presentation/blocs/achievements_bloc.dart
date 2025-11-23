import 'package:academia/database/database.dart';
import 'package:academia/features/streaks/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'achievements_event.dart';
part 'achievements_state.dart';

class AchievementsBloc extends Bloc<AchievementsEvent, AchievementsState> {
  final GetAchievements getAchievements;
  static const int _pageSize = 20;

  AchievementsBloc({required this.getAchievements}) : super(AchievementsInitial()) {
    on<LoadAchievements>(_onLoadAchievements);
    on<LoadMoreAchievements>(_onLoadMoreAchievements);
    on<RefreshAchievements>(_onRefreshAchievements);
  }

  Future<void> _onLoadAchievements(
    LoadAchievements event,
    Emitter<AchievementsState> emit,
  ) async {
    emit(AchievementsLoading());

    final result = await getAchievements(
      GetAchievementsParams(
        page: 1,
        pageSize: _pageSize,
        forceRefresh: false,
      ),
    );

    result.fold(
      (failure) => emit(AchievementsError(message: failure.message)),
      (paginated) => emit(
        AchievementsLoaded(
          achievements: paginated.entries,
          totalCount: paginated.totalCount,
          hasMore: paginated.hasNext,
          currentPage: 1,
        ),
      ),
    );
  }

  Future<void> _onLoadMoreAchievements(
    LoadMoreAchievements event,
    Emitter<AchievementsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! AchievementsLoaded || !currentState.hasMore) return;

    emit(
      AchievementsLoadingMore(
        achievements: currentState.achievements,
        totalCount: currentState.totalCount,
        hasMore: currentState.hasMore,
        currentPage: currentState.currentPage,
      ),
    );

    final nextPage = currentState.currentPage + 1;
    final result = await getAchievements(
      GetAchievementsParams(
        page: nextPage,
        pageSize: _pageSize,
        forceRefresh: false,
      ),
    );

    result.fold(
      (failure) => emit(currentState), // Revert to previous state
      (paginated) => emit(
        AchievementsLoaded(
          achievements: [...currentState.achievements, ...paginated.entries],
          totalCount: paginated.totalCount,
          hasMore: paginated.hasNext,
          currentPage: nextPage,
        ),
      ),
    );
  }

  Future<void> _onRefreshAchievements(
    RefreshAchievements event,
    Emitter<AchievementsState> emit,
  ) async {
    // Keep current state while refreshing
    final result = await getAchievements(
      GetAchievementsParams(
        page: 1,
        pageSize: _pageSize,
        forceRefresh: true,
      ),
    );

    result.fold(
      (failure) {
        if (state is AchievementsLoaded) {
          // Keep showing current data on refresh error
        } else {
          emit(const AchievementsError(message: 'Failed to refresh'));
        }
      },
      (paginated) => emit(
        AchievementsLoaded(
          achievements: paginated.entries,
          totalCount: paginated.totalCount,
          hasMore: paginated.hasNext,
          currentPage: 1,
        ),
      ),
    );
  }
}
