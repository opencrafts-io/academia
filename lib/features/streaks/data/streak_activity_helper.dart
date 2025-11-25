import 'package:academia/database/database.dart';
import 'package:academia/features/streaks/domain/domain.dart';

extension StreakActivityHelper on StreakActivityData {
  StreakActivity toEntity() => StreakActivity(
    id: id,
    name: name,
    category: category,
    pointsAwarded: pointsAwarded,
    maxDailyCompletions: maxDailyCompletions,
    streakEligible: streakEligible,
    isActive: isActive,
    createdAt: createdAt,
    updatedAt: updatedAt,
    cachedAt: cachedAt,
  );
}
