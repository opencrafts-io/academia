import 'package:academia/database/database.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'streak_activity.freezed.dart';

@freezed
abstract class StreakActivity with _$StreakActivity {
  const StreakActivity._();
  const factory StreakActivity({
    required String id,
    required String name,
    required String category,
    required int pointsAwarded,
    required int maxDailyCompletions,
    required bool streakEligible,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? cachedAt,
  }) = _StreakActivity;
 
  StreakActivityData toData() => StreakActivityData(
    id: id,
    name: name,
    category: category,
    pointsAwarded: pointsAwarded,
    maxDailyCompletions: maxDailyCompletions,
    streakEligible: streakEligible,
    isActive: isActive,
    createdAt: createdAt,
    updatedAt: updatedAt,
    cachedAt: cachedAt ?? DateTime.now(),
  );
}
