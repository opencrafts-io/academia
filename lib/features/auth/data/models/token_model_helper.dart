import 'package:academia/database/database.dart';
import 'package:academia/features/auth/auth.dart';

extension TokenModelHelper on TokenData {
  Token toEntity() => Token(
    id: id,
    provider: provider,
    expiresAt: expiresAt,
    refreshToken: refreshToken,
    accessToken: accessToken,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension TokenEntityHelper on Token {
  TokenData toData() => TokenData(
    id: id,
    createdAt: createdAt,
    updatedAt: updatedAt,
    accessToken: accessToken,
    refreshToken: refreshToken,
    provider: provider,
  );
}
