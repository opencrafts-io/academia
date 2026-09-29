import 'package:freezed_annotation/freezed_annotation.dart';
part 'todo_tag_dto.freezed.dart';
part 'todo_tag_dto.g.dart';

@freezed
abstract class TodoTagDto with _$TodoTagDto {
  const factory TodoTagDto({
    required String? id,
    required String name,
    required String? color,
    @JsonKey(name: 'created_at') required String? createdAt,
  }) = _TodoTagDto;

  factory TodoTagDto.fromJson(Map<String, dynamic> json) =>
      _$TodoTagDtoFromJson(json);
}
