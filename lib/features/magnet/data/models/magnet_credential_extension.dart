import 'package:academia/database/database.dart';
import 'package:academia/features/magnet/domain/domain.dart' as magnet_domain;
import 'package:magnet/magnet.dart';

extension MagnetCredentialExtension on MagnetCredential {
  Credentials toMagnet() => Credentials(password: password, username: username);

  magnet_domain.MagnetCredential toEntity() => magnet_domain.MagnetCredential(
    userID: userID,
    username: username,
    password: password,
    institutionID: institutionID,
  );
}

extension CredentialExtension on Credentials {
  MagnetCredential toData({
    required String userID,
    required int institutionID,
  }) => MagnetCredential(
    userID: userID,
    username: username,
    password: password,
    institutionID: institutionID,
  );

  magnet_domain.MagnetCredential toEntity({
    required String userID,
    required int institutionID,
  }) => magnet_domain.MagnetCredential(
    userID: userID,
    username: username,
    password: password,
    institutionID: institutionID,
  );
}

extension MagnetCredentialEntityExtension on magnet_domain.MagnetCredential {
  MagnetCredential toData() => MagnetCredential(
    userID: userID,
    username: username,
    password: password,
    institutionID: institutionID,
  );

  Credentials toMagnet() => Credentials(password: password, username: username);
}
