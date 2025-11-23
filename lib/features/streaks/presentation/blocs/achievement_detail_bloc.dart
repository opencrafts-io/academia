import 'package:academia/database/database.dart';
import 'package:academia/features/streaks/domain/usecases/get_achievement_by_id.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'achievement_detail_event.dart';
part 'achievement_detail_state.dart';

class AchievementDetailBloc extends Bloc<AchievementDetailEvent, AchievementDetailState> {
  final GetAchievementById getAchievementById;

  AchievementDetailBloc({required this.getAchievementById}) : super(AchievementDetailInitial()) {
    on<LoadAchievementDetail>(_onLoadAchievementDetail);
  }

  Future<void> _onLoadAchievementDetail(
    LoadAchievementDetail event,
    Emitter<AchievementDetailState> emit,
  ) async {
    emit(AchievementDetailLoading());

    final result = await getAchievementById(event.id);

    result.fold(
      (failure) => emit(AchievementDetailError(failure.message)),
      (achievement) => emit(AchievementDetailLoaded(achievement)),
    );
  }
}
