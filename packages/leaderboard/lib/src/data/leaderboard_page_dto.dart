import 'package:freezed_annotation/freezed_annotation.dart';

import 'leaderboard_entry_dto.dart';

part 'leaderboard_page_dto.freezed.dart';
part 'leaderboard_page_dto.g.dart';

@freezed
abstract class LeaderboardPageDto with _$LeaderboardPageDto {
  const factory LeaderboardPageDto({
    @Default(0) int count,
    String? next,
    String? previous,
    @Default(<LeaderboardEntryDto>[]) List<LeaderboardEntryDto> results,
  }) = _LeaderboardPageDto;

  factory LeaderboardPageDto.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardPageDtoFromJson(json);
}
