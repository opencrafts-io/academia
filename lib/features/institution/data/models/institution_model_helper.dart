import 'package:academia/database/database.dart';
import 'package:academia/features/institution/domain/domain.dart';

extension InstitutionModelHelper on Institution {
  InstitutionData toData() => InstitutionData(
    institutionId: institutionId,
    name: name,
    domains: domains,
    country: country,
    webPages: webPages,
    alphaTwoCode: alphaTwoCode,
    stateProvince: stateProvince,
  );
}

extension InstitutionDataModelHelper on InstitutionData {
  Institution toEntity() => Institution(
    institutionId: institutionId,
    name: name,
    domains: domains,
    country: country,
    webPages: webPages,
    alphaTwoCode: alphaTwoCode,
    stateProvince: stateProvince,
  );
}
