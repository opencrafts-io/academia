import 'package:academia/database/database.dart';
import 'package:academia/features/streaks/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'achievement_detail_event.dart';
part 'achievement_detail_state.dart';

class AchievementDetailBloc extends Bloc<AchievementDetailEvent, AchievementDetailState> {
  final GetAchievementById getAchievementById;
  final GetActivityById getActivityById;

  AchievementDetailBloc({
    required this.getAchievementById,
    required this.getActivityById,
  }) : super(AchievementDetailInitial()) {
    on<LoadAchievementDetail>(_onLoadAchievementDetail);
  }

  Future<void> _onLoadAchievementDetail(
    LoadAchievementDetail event,
    Emitter<AchievementDetailState> emit,
  ) async {
    emit(AchievementDetailLoading());

    final achievementResult = await getAchievementById(event.id);

    await achievementResult.fold(
      (failure) async => emit(AchievementDetailError(failure.message)),
      (achievement) async {
        final activityResult = await getActivityById(achievement.activityID);
        activityResult.fold(
          (failure) => emit(AchievementDetailLoaded(achievement)),
          (activity) => emit(AchievementDetailLoaded(achievement, activity: activity)),
        );
      },
    );
  }
}
