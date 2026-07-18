import 'package:academia/database/database.dart' as db;
import 'package:academia/features/institution/institution.dart';

extension InstitutionProfileHelper on InstitutionProfile {
  db.InstitutionProfile toData() => db.InstitutionProfile.fromJson(toJson());
}

extension InstitutionProfileDataHelper on db.InstitutionProfile {
  InstitutionProfile toEntity() => InstitutionProfile.fromJson(toJson());
}
