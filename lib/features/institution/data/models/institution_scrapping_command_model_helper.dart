import 'package:academia/database/database.dart';
import 'package:magnet/magnet.dart';

extension InstitutionScrappingCommandModelHelper
    on InstitutionScrappingCommand {
  ScrappingCommand toEntity() => ScrappingCommand.fromJson(toJson());
}

extension InstitutionScrappingCommandEntityHelper on ScrappingCommand {
  InstitutionScrappingCommand toData() =>
      InstitutionScrappingCommand.fromJson(toJson());
}
