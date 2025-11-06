// lib/features/leaderboard/presentation/bloc/leaderboard_bloc.dart
import 'package:academia/features/leaderboard/leaderboard.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'leaderboard_event.dart';
part 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final GetGlobalLeaderboardUsecase getGlobalLeaderboardUsecase;
  static const int _pageSize = 100;

  LeaderboardBloc({required this.getGlobalLeaderboardUsecase})
    : super(LeaderboardInitial()) {
    on<LoadLeaderboard>(_onLoadLeaderboard);
    on<LoadMoreLeaderboard>(_onLoadMoreLeaderboard);
    on<RefreshLeaderboard>(_onRefreshLeaderboard);
  }

  Future<void> _onLoadLeaderboard(
    LoadLeaderboard event,
    Emitter<LeaderboardState> emit,
  ) async {
    emit(LeaderboardLoading());

    final result = await getGlobalLeaderboardUsecase(
      GetGlobalLeaderboardUsecaseParams(
        page: 1,
        pageSize: _pageSize,
        forceRefresh: false,
      ),
    );

    result.fold(
      (failure) =>
          emit(const LeaderboardError(message: 'Failed to load leaderboard')),
      (paginated) => emit(
        LeaderboardLoaded(
          entries: paginated.entries,
          totalCount: paginated.totalCount,
          hasMore: paginated.hasNext,
          currentPage: 1,
        ),
      ),
    );
  }

  Future<void> _onLoadMoreLeaderboard(
    LoadMoreLeaderboard event,
    Emitter<LeaderboardState> emit,
  ) async {
    final currentState = state;
    if (currentState is! LeaderboardLoaded || !currentState.hasMore) return;

    emit(
      LeaderboardLoadingMore(
        entries: currentState.entries,
        totalCount: currentState.totalCount,
        hasMore: currentState.hasMore,
        currentPage: currentState.currentPage,
      ),
    );

    final nextPage = currentState.currentPage + 1;
    final result = await getGlobalLeaderboardUsecase(
      GetGlobalLeaderboardUsecaseParams(
        page: nextPage,
        pageSize: _pageSize,
        forceRefresh: false,
      ),
    );

    result.fold(
      (failure) => emit(currentState), // Revert to previous state
      (paginated) => emit(
        LeaderboardLoaded(
          entries: [...currentState.entries, ...paginated.entries],
          totalCount: paginated.totalCount,
          hasMore: paginated.hasNext,
          currentPage: nextPage,
        ),
      ),
    );
  }

  Future<void> _onRefreshLeaderboard(
    RefreshLeaderboard event,
    Emitter<LeaderboardState> emit,
  ) async {
    // Keep current state while refreshing
    final result = await getGlobalLeaderboardUsecase(
      GetGlobalLeaderboardUsecaseParams(
        page: 1,
        pageSize: _pageSize,
        forceRefresh: true,
      ),
    );

    result.fold(
      (failure) {
        if (state is LeaderboardLoaded) {
          // Keep showing current data on refresh error
        } else {
          emit(const LeaderboardError(message: 'Failed to refresh'));
        }
      },
      (paginated) => emit(
        LeaderboardLoaded(
          entries: paginated.entries,
          totalCount: paginated.totalCount,
          hasMore: paginated.hasNext,
          currentPage: 1,
        ),
      ),
    );
  }
}
