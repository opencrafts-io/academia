import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/domain.dart';

part 'leaderboard_bloc.freezed.dart';

@freezed
sealed class LeaderboardState with _$LeaderboardState {
  const factory LeaderboardState.initial() = _Initial;
  const factory LeaderboardState.loading() = _Loading;
  const factory LeaderboardState.loaded(LeaderboardPage page) = _Loaded;
  const factory LeaderboardState.failure(String message) = _Failure;
}

sealed class LeaderboardEvent {
  const LeaderboardEvent();
}

final class LoadGlobalLeaderboard extends LeaderboardEvent {
  const LoadGlobalLeaderboard({this.page = 1, this.append = false});
  final int page;
  final bool append;
}

final class LoadLeaderboardAroundUser extends LeaderboardEvent {
  const LoadLeaderboardAroundUser(this.accountId);
  final String accountId;
}

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  LeaderboardBloc({
    required this.getGlobalLeaderboard,
    required this.getLeaderboardAroundUser,
  }) : super(const LeaderboardState.initial()) {
    on<LoadGlobalLeaderboard>(_loadGlobal);
    on<LoadLeaderboardAroundUser>(_loadAroundUser);
  }

  final GetGlobalLeaderboard getGlobalLeaderboard;
  final GetLeaderboardAroundUser getLeaderboardAroundUser;
  bool _loadingMore = false;

  Future<void> _loadGlobal(
    LoadGlobalLeaderboard event,
    Emitter<LeaderboardState> emit,
  ) async {
    if (event.append && _loadingMore) return;
    if (event.append) _loadingMore = true;
    final previous = state.maybeWhen(
      loaded: (page) => page,
      orElse: () => null,
    );
    if (!event.append) emit(const LeaderboardState.loading());
    try {
      final result = await getGlobalLeaderboard(page: event.page, pageSize: 20);
      result.fold(
        (failure) => emit(
          event.append && previous != null
              ? LeaderboardState.loaded(previous)
              : LeaderboardState.failure(failure.message),
        ),
        (page) => emit(
          LeaderboardState.loaded(
            event.append && previous != null
                ? page.copyWith(entries: [...previous.entries, ...page.entries])
                : page,
          ),
        ),
      );
    } finally {
      if (event.append) _loadingMore = false;
    }
  }

  Future<void> _loadAroundUser(
    LoadLeaderboardAroundUser event,
    Emitter<LeaderboardState> emit,
  ) async {
    emit(const LeaderboardState.loading());
    final result = await getLeaderboardAroundUser(
      accountId: event.accountId,
      limit: 20,
    );
    result.fold(
      (failure) => emit(LeaderboardState.failure(failure.message)),
      (page) => emit(LeaderboardState.loaded(page)),
    );
  }
}
