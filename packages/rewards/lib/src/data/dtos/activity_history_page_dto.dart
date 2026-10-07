import 'package:freezed_annotation/freezed_annotation.dart';

import 'activity_history_dto.dart';

part 'activity_history_page_dto.freezed.dart';
part 'activity_history_page_dto.g.dart';

@freezed
abstract class ActivityHistoryPageDto with _$ActivityHistoryPageDto {
  const factory ActivityHistoryPageDto({
    @Default(0) int count,
    String? next,
    String? previous,
    @Default(<ActivityHistoryDto>[]) List<ActivityHistoryDto> results,
  }) = _ActivityHistoryPageDto;

  factory ActivityHistoryPageDto.fromJson(Map<String, dynamic> json) =>
      _$ActivityHistoryPageDtoFromJson(json);
}
