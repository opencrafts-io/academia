import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_api_dto.freezed.dart';
part 'report_api_dto.g.dart';

@freezed
abstract class ReportApiDto with _$ReportApiDto {
  const factory ReportApiDto({
    required int id,
    @JsonKey(name: 'report_type') required String reportType,
    @JsonKey(name: 'reported_user') String? reportedUser,
    @JsonKey(name: 'reported_post') int? reportedPost,
    @JsonKey(name: 'reported_comment') int? reportedComment,
    @JsonKey(name: 'reported_community') int? reportedCommunity,
    required String reason,
    required String status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _ReportApiDto;

  factory ReportApiDto.fromJson(Map<String, dynamic> json) =>
      _$ReportApiDtoFromJson(json);
}
