import 'package:freezed_annotation/freezed_annotation.dart';

import 'activity_dto.dart';

part 'activity_page_dto.freezed.dart';
part 'activity_page_dto.g.dart';

@freezed
abstract class ActivityPageDto with _$ActivityPageDto {
  const factory ActivityPageDto({
    @Default(0) int count,
    String? next,
    String? previous,
    @Default(<ActivityDto>[]) List<ActivityDto> results,
  }) = _ActivityPageDto;

  factory ActivityPageDto.fromJson(Map<String, dynamic> json) =>
      _$ActivityPageDtoFromJson(json);
}
