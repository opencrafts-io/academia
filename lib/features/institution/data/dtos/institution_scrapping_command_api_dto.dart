import 'package:freezed_annotation/freezed_annotation.dart';

part 'institution_scrapping_command_api_dto.freezed.dart';
part 'institution_scrapping_command_api_dto.g.dart';

@freezed
abstract class InstitutionScrappingCommandApiDto
    with _$InstitutionScrappingCommandApiDto {
  const factory InstitutionScrappingCommandApiDto({
    required int institution,
    @JsonKey(name: 'command_id') required String commandId,
    required String name,
    String? url,
    String? description,
    @JsonKey(name: 'requires_interaction')
    @Default(false)
    bool requiresInteraction,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    required List<dynamic> instructions,
  }) = _InstitutionScrappingCommandApiDto;

  factory InstitutionScrappingCommandApiDto.fromJson(
    Map<String, dynamic> json,
  ) => _$InstitutionScrappingCommandApiDtoFromJson(json);
}
