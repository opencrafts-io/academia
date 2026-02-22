import 'package:academia/features/institution/domain/domain.dart';
import 'package:academia/database/database.dart';

extension InstitutionKeyModelHelper on InstitutionKeyData {
  InstitutionKey toEntity() => InstitutionKey(
    keySets: keySets,
    commandId: commandID,
    createdAt: createdAt ?? DateTime.now(),
    institutionId: institutionID,
  );
}

extension InstitutionKeyEntityHelper on InstitutionKey {
  InstitutionKeyData toData() => InstitutionKeyData(
    createdAt: createdAt,
    keySets: keySets,
    commandID: commandId,
    institutionID: institutionId,
  );
}
