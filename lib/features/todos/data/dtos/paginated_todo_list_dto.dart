import 'package:freezed_annotation/freezed_annotation.dart';

import './todo_list_dto.dart';
part 'paginated_todo_list_dto.freezed.dart';
part 'paginated_todo_list_dto.g.dart';



@freezed
abstract class PaginatedTodoListDto with _$PaginatedTodoListDto {
  const factory PaginatedTodoListDto({
    required int count,
    required String? next,
    required String? previous,
    required List<TodoListDto> results,
  }) = _PaginatedTodoListDto;

  factory PaginatedTodoListDto.fromJson(Map<String, dynamic> json) =>
      _$PaginatedTodoListDtoFromJson(json);
}
