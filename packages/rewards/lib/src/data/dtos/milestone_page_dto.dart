import 'package:freezed_annotation/freezed_annotation.dart';

import 'milestone_dto.dart';

part 'milestone_page_dto.freezed.dart';
part 'milestone_page_dto.g.dart';

@freezed
abstract class MilestonePageDto with _$MilestonePageDto {
  const factory MilestonePageDto({
    @Default(0) int count,
    String? next,
    String? previous,
    @Default(<MilestoneDto>[]) List<MilestoneDto> results,
  }) = _MilestonePageDto;

  factory MilestonePageDto.fromJson(Map<String, dynamic> json) =>
      _$MilestonePageDtoFromJson(json);
}
