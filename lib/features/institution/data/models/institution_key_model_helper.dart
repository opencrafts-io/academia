import 'package:academia/features/institution/domain/domain.dart';
import 'package:academia/database/database.dart' as db;

extension InstitutionKeyModelHelper on db.InstitutionKey {
  InstitutionKey toEntity() => InstitutionKey(
    keySets: keySets,
    commandId: commandID,
    createdAt: createdAt ?? DateTime.now(),
    institutionId: institutionID,
  );
}

extension InstitutionKeyEntityHelper on InstitutionKey {
  db.InstitutionKey toData() => db.InstitutionKey(
    createdAt: createdAt,
    keySets: keySets,
    commandID: commandId,
    institutionID: institutionId,
  );
}
