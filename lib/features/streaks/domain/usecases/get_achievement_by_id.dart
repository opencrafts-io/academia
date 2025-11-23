import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/streaks/domain/repositories/achievement_repository.dart';
import 'package:dartz/dartz.dart';

class GetAchievementById implements UseCase<StreakMilestoneData, String> {
  final AchievementRepository repository;

  GetAchievementById(this.repository);

  @override
  Future<Either<Failure, StreakMilestoneData>> call(String id) async {
    return await repository.getAchievementById(id);
  }
}
