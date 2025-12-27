import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/streaks/domain/repositories/achievement_repository.dart';
import 'package:dartz/dartz.dart';

class GetActivityById implements UseCase<StreakActivityData, String> {
  final AchievementRepository repository;

  GetActivityById(this.repository);

  @override
  Future<Either<Failure, StreakActivityData>> call(String id) async {
    return await repository.getActivityById(id);
  }
}
