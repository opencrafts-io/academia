import 'package:academia/features/auth/auth.dart';
import './token.dart';

extension TokenModelHelper on TokenData {
  Token toEntity() => Token(
    provider: provider,
    refreshToken: refreshToken,
    accessToken: accessToken,
    accessExpiresAt: accessExpiresAt,
    refreshExpiresAt: refreshExpiresAt,
  );
}

extension TokenEntityHelper on Token {
  TokenData toData() => TokenData(
    provider: provider,
    refreshToken: refreshToken,
    accessToken: accessToken,
    accessExpiresAt: accessExpiresAt,
    refreshExpiresAt: refreshExpiresAt,
  );
}
