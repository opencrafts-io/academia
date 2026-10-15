import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_history.freezed.dart';

@freezed
abstract class ActivityHistory with _$ActivityHistory {
  const factory ActivityHistory({
    required String id,
    required String activityId,
    String? activityName,
    required int pointsEarned,
    DateTime? createdAt,
  }) = _ActivityHistory;
}
