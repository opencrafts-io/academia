import 'package:freezed_annotation/freezed_annotation.dart';
import './todo_item_dto.dart';
part 'paginated_todo_item_dto.freezed.dart';
part 'paginated_todo_item_dto.g.dart';

@freezed
abstract class PaginatedTodoItemDto with _$PaginatedTodoItemDto {
  const factory PaginatedTodoItemDto({
    required int count,
    required String? next,
    required String? previous,
    required List<TodoItemDto> results,
  }) = _PaginatedTodoItemDto;

  factory PaginatedTodoItemDto.fromJson(Map<String, dynamic> json) =>
      _$PaginatedTodoItemDtoFromJson(json);
}
