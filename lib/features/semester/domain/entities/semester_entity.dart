import 'package:freezed_annotation/freezed_annotation.dart';

part 'semester_entity.freezed.dart';

@freezed
abstract class SemesterEntity with _$SemesterEntity {
  const factory SemesterEntity({
    required int id, 
    required String name,
    String? description,
    int? institutionId,
    required DateTime startDate,
    required DateTime endDate,
  }) = _SemesterEntity;
}
