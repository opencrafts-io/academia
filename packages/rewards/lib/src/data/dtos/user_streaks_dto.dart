import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_streak_dto.dart';

part 'user_streaks_dto.freezed.dart';
part 'user_streaks_dto.g.dart';

@freezed
abstract class UserStreaksDto with _$UserStreaksDto {
  const factory UserStreaksDto({
    @Default(<UserStreakDto>[]) List<UserStreakDto> streaks,
    @Default(<UserStreakDto>[]) List<UserStreakDto> results,
  }) = _UserStreaksDto;

  factory UserStreaksDto.fromJson(Map<String, dynamic> json) =>
      _$UserStreaksDtoFromJson(json);
}
