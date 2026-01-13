import 'package:academia/database/database.dart';
import 'package:magnet/magnet.dart';

extension InstitutionScrappingCommandModelHelper
    on InstitutionScrappingCommandData {
  ScrappingCommand toEntity() => ScrappingCommand.fromJson(toJson());
}

extension InstitutionScrappingCommandEntityHelper on ScrappingCommand {
  InstitutionScrappingCommandData toData() =>
      InstitutionScrappingCommandData.fromJson(toJson());
}
