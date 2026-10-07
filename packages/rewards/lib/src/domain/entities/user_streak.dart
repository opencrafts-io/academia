import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_streak.freezed.dart';

@freezed
abstract class UserStreak with _$UserStreak {
  const factory UserStreak({
    required String activityId,
    required int currentStreak,
    required int longestStreak,
    DateTime? lastActivityDate,
  }) = _UserStreak;
}
