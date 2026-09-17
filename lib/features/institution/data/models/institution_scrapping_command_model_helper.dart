import 'package:academia/database/database.dart';
import 'package:academia/features/institution/data/dtos/institution_scrapping_command_api_dto.dart';
import 'package:magnet/magnet.dart';

extension InstitutionScrappingCommandApiDtoMapper
    on InstitutionScrappingCommandApiDto {
  InstitutionScrappingCommand toData() => InstitutionScrappingCommand(
    institution: institution,
    commandID: commandId,
    name: name,
    url: url,
    description: description,
    requiresInteraction: requiresInteraction,
    createdAt: createdAt,
    instructions: instructions,
  );

  ScrappingCommand toEntity() => toData().toEntity();
}

extension InstitutionScrappingCommandModelHelper
    on InstitutionScrappingCommand {
  ScrappingCommand toEntity() => ScrappingCommand.fromJson(toJson());
}

extension InstitutionScrappingCommandEntityHelper on ScrappingCommand {
  InstitutionScrappingCommand toData() =>
      InstitutionScrappingCommand.fromJson(toJson());
}
