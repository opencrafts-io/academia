import 'package:freezed_annotation/freezed_annotation.dart';

part 'lecturer_entity.freezed.dart';

@freezed
abstract class LecturerEntity with _$LecturerEntity {
  const factory LecturerEntity({
    required String id,
    required String courseId,
    required String name,
    String? email,
    String? phone,
    String? office,
  }) = _LecturerEntity;
}
