import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity.freezed.dart';

@freezed
abstract class EarnableActivity with _$EarnableActivity {
  const factory EarnableActivity({
    required String id,
    required String name,
    required String category,
    required int pointsAwarded,
    required int maxDailyCompletions,
    required bool streakEligible,
    String? code,
    String? slug,
    String? description,
  }) = _EarnableActivity;
}
