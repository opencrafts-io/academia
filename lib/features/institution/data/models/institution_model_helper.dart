import 'package:academia/database/database.dart' as db;
import 'package:academia/features/institution/domain/domain.dart';

extension InstitutionModelHelper on Institution {
  db.Institution toData() => db.Institution(
    institutionId: institutionId,
    name: name,
    domains: domains,
    country: country,
    webPages: webPages,
    alphaTwoCode: alphaTwoCode,
    stateProvince: stateProvince,
  );
}

extension InstitutionDataModelHelper on db.Institution {
  Institution toEntity() => Institution(
    institutionId: institutionId,
    name: name,
    domains: domains?.cast<String>() ?? [],
    country: country,
    webPages: webPages?.cast<String>() ?? [],
    alphaTwoCode: alphaTwoCode,
    stateProvince: stateProvince,
  );
}
