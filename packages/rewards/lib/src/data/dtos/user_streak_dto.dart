import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user_streak.dart';

part 'user_streak_dto.freezed.dart';
part 'user_streak_dto.g.dart';

@freezed
abstract class UserStreakDto with _$UserStreakDto {
  const UserStreakDto._();

  const factory UserStreakDto({
    @JsonKey(name: 'activity_id') @Default('') String activityId,
    @JsonKey(name: 'current_streak') @Default(0) int currentStreak,
    @JsonKey(name: 'longest_streak') @Default(0) int longestStreak,
    @JsonKey(name: 'last_activity_date') DateTime? lastActivityDate,
  }) = _UserStreakDto;

  factory UserStreakDto.fromJson(Map<String, dynamic> json) =>
      _$UserStreakDtoFromJson(json);

  UserStreak toDomain() => UserStreak(
    activityId: activityId,
    currentStreak: currentStreak,
    longestStreak: longestStreak,
    lastActivityDate: lastActivityDate,
  );
}
