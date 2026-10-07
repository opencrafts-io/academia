import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/activity.dart';

part 'activity_dto.freezed.dart';
part 'activity_dto.g.dart';

@freezed
abstract class ActivityDto with _$ActivityDto {
  const ActivityDto._();

  const factory ActivityDto({
    @Default('') String id,
    @Default('') String name,
    @Default('') String category,
    @JsonKey(name: 'points_awarded') @Default(0) int pointsAwarded,
    @JsonKey(name: 'max_daily_completions') @Default(0) int maxDailyCompletions,
    @JsonKey(name: 'streak_eligible') @Default(false) bool streakEligible,
    String? code,
    String? slug,
    String? description,
  }) = _ActivityDto;

  factory ActivityDto.fromJson(Map<String, dynamic> json) =>
      _$ActivityDtoFromJson(json);

  EarnableActivity toDomain() => EarnableActivity(
    id: id,
    name: name,
    category: category,
    pointsAwarded: pointsAwarded,
    maxDailyCompletions: maxDailyCompletions,
    streakEligible: streakEligible,
    code: code,
    slug: slug,
    description: description,
  );
}
