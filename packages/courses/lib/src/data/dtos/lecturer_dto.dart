import 'package:freezed_annotation/freezed_annotation.dart';

part 'lecturer_dto.freezed.dart';
part 'lecturer_dto.g.dart';

@freezed
abstract class LecturerDto with _$LecturerDto {
  const factory LecturerDto({
    required String id,
    required String name,
    String? email,
    String? phone,
    String? office,
  }) = _LecturerDto;

  factory LecturerDto.fromJson(Map<String, dynamic> json) =>
      _$LecturerDtoFromJson(json);
}
