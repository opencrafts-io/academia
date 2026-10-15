import 'package:freezed_annotation/freezed_annotation.dart';

import 'leaderboard_entry_dto.dart';

part 'leaderboard_around_dto.freezed.dart';
part 'leaderboard_around_dto.g.dart';

@freezed
abstract class LeaderboardAroundDto with _$LeaderboardAroundDto {
  const LeaderboardAroundDto._();

  const factory LeaderboardAroundDto({
    @Default(<LeaderboardEntryDto>[]) List<LeaderboardEntryDto> results,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'user_position') int? userPosition,
    @JsonKey(name: 'total_users') @Default(0) int totalUsers,
  }) = _LeaderboardAroundDto;

  factory LeaderboardAroundDto.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardAroundDtoFromJson(json);
}
