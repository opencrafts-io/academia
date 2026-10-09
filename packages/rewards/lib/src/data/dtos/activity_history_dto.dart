import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/activity_history.dart';

part 'activity_history_dto.freezed.dart';
part 'activity_history_dto.g.dart';

@freezed
abstract class ActivityHistoryDto with _$ActivityHistoryDto {
  const ActivityHistoryDto._();

  const factory ActivityHistoryDto({
    @Default('') String id,
    @JsonKey(name: 'activity_id') @Default('') String activityId,
    @JsonKey(name: 'activity_name') String? activityName,
    @JsonKey(name: 'points_earned') @Default(0) int pointsEarned,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _ActivityHistoryDto;

  factory ActivityHistoryDto.fromJson(Map<String, dynamic> json) =>
      _$ActivityHistoryDtoFromJson(json);

  ActivityHistory toDomain() => ActivityHistory(
    id: id,
    activityId: activityId,
    activityName: activityName,
    pointsEarned: pointsEarned,
    createdAt: createdAt,
  );
}
