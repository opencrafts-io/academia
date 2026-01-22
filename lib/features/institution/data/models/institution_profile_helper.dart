import 'package:academia/database/database.dart';
import 'package:academia/features/institution/institution.dart';

extension InstitutionProfileHelper on InstitutionProfile {
  InstitutionProfileData toData() => InstitutionProfileData.fromJson(toJson());
}

extension InstitutionProfileDataHelper on InstitutionProfileData {
  InstitutionProfile toEntity() => InstitutionProfile.fromJson(toJson());
}
