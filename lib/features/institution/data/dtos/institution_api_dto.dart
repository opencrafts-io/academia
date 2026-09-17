import 'package:freezed_annotation/freezed_annotation.dart';

part 'institution_api_dto.freezed.dart';
part 'institution_api_dto.g.dart';

@freezed
abstract class InstitutionApiDto with _$InstitutionApiDto {
  const factory InstitutionApiDto({
    @JsonKey(name: 'institution_id') required int institutionId,
    required String name,
    @JsonKey(name: 'web_pages') List<String>? webPages,
    List<String>? domains,
    @JsonKey(name: 'alpha_two_code') String? alphaTwoCode,
    String? country,
    @JsonKey(name: 'state_province') String? stateProvince,
  }) = _InstitutionApiDto;

  factory InstitutionApiDto.fromJson(Map<String, dynamic> json) =>
      _$InstitutionApiDtoFromJson(json);
}
