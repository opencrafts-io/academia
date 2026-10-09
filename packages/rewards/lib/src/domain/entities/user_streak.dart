import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_streak.freezed.dart';

@freezed
abstract class UserStreak with _$UserStreak {
  const factory UserStreak({
    required String activityName,
    required int currentStreak,
    required int longestStreak,
    required int daysUntilNextMilestone,
    required int totalCompletions,
    String? lastCompletionDate,
  }) = _UserStreak;
}
