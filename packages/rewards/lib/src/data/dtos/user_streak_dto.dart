import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user_streak.dart';

part 'user_streak_dto.freezed.dart';
part 'user_streak_dto.g.dart';

@freezed
abstract class UserStreakDto with _$UserStreakDto {
  const UserStreakDto._();

  const factory UserStreakDto({
    @JsonKey(name: 'activity_name') @Default('') String activityName,
    @JsonKey(name: 'current_streak') @Default(0) int currentStreak,
    @JsonKey(name: 'longest_streak') @Default(0) int longestStreak,
    @JsonKey(name: 'days_until_next_milestone')
    @Default(0)
    int daysUntilNextMilestone,
    @JsonKey(name: 'total_completions') @Default(0) int totalCompletions,
    @JsonKey(name: 'last_completion_date') String? lastCompletionDate,
  }) = _UserStreakDto;

  factory UserStreakDto.fromJson(Map<String, dynamic> json) =>
      _$UserStreakDtoFromJson(json);

  UserStreak toDomain() => UserStreak(
    activityName: activityName,
    currentStreak: currentStreak,
    longestStreak: longestStreak,
    daysUntilNextMilestone: daysUntilNextMilestone,
    totalCompletions: totalCompletions,
    lastCompletionDate: lastCompletionDate,
  );
}
