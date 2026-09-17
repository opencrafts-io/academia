import 'package:freezed_annotation/freezed_annotation.dart';
import './todo_tag_dto.dart';
part 'paginated_todo_tag_dto.freezed.dart';
part 'paginated_todo_tag_dto.g.dart';

@freezed
abstract class PaginatedTodoTagDto with _$PaginatedTodoTagDto {
  const factory PaginatedTodoTagDto({
    required int count,
    required String? next,
    required String? previous,
    required List<TodoTagDto> results,
  }) = _PaginatedTodoTagDto;

  factory PaginatedTodoTagDto.fromJson(Map<String, dynamic> json) =>
      _$PaginatedTodoTagDtoFromJson(json);
}
