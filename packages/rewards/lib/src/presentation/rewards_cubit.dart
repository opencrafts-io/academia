import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/domain.dart';

part 'rewards_cubit.freezed.dart';

@freezed
sealed class RewardsState with _$RewardsState {
  const factory RewardsState.initial() = _Initial;
  const factory RewardsState.loading() = _Loading;
  const factory RewardsState.loaded(RewardsOverview overview) = _Loaded;
  const factory RewardsState.failure(String message) = _Failure;
}

class RewardsCubit extends SafeCubit<RewardsState> {
  RewardsCubit(this._getRewardsOverview) : super(const RewardsState.initial());

  final GetRewardsOverview _getRewardsOverview;

  Future<void> load() async {
    emit(const RewardsState.loading());
    final result = await _getRewardsOverview();
    result.fold(
      (failure) => emit(RewardsState.failure(failure.message)),
      (overview) => emit(RewardsState.loaded(overview)),
    );
  }
}
