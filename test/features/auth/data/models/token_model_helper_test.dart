import 'package:academia/features/auth/data/models/token.dart';
import 'package:academia/features/auth/data/models/token_model_helper.dart';
import 'package:academia/features/auth/domain/entities/token.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tAccessExpiresAt = DateTime.utc(2026, 6, 1, 12, 0, 0);
  final tRefreshExpiresAt = DateTime.utc(2026, 12, 1, 12, 0, 0);

  final tTokenData = TokenData(
    provider: 'verisafe',
    accessToken: 'access-token-abc',
    refreshToken: 'refresh-token-xyz',
    accessExpiresAt: tAccessExpiresAt,
    refreshExpiresAt: tRefreshExpiresAt,
  );

  final tTokenEntity = Token(
    provider: 'verisafe',
    accessToken: 'access-token-abc',
    refreshToken: 'refresh-token-xyz',
    accessExpiresAt: tAccessExpiresAt,
    refreshExpiresAt: tRefreshExpiresAt,
  );

  group('TokenModelHelper (TokenData -> Token)', () {
    test('toEntity should map all fields correctly', () {
      final entity = tTokenData.toEntity();

      expect(entity.provider, tTokenData.provider);
      expect(entity.accessToken, tTokenData.accessToken);
      expect(entity.refreshToken, tTokenData.refreshToken);
      expect(entity.accessExpiresAt, tTokenData.accessExpiresAt);
      expect(entity.refreshExpiresAt, tTokenData.refreshExpiresAt);
    });

    test('toEntity should return a Token instance', () {
      expect(tTokenData.toEntity(), isA<Token>());
    });

    test('toEntity equality: result equals manually created Token entity', () {
      final entity = tTokenData.toEntity();
      expect(entity, tTokenEntity);
    });
  });

  group('TokenEntityHelper (Token -> TokenData)', () {
    test('toData should map all fields correctly', () {
      final data = tTokenEntity.toData();

      expect(data.provider, tTokenEntity.provider);
      expect(data.accessToken, tTokenEntity.accessToken);
      expect(data.refreshToken, tTokenEntity.refreshToken);
      expect(data.accessExpiresAt, tTokenEntity.accessExpiresAt);
      expect(data.refreshExpiresAt, tTokenEntity.refreshExpiresAt);
    });

    test('toData should return a TokenData instance', () {
      expect(tTokenEntity.toData(), isA<TokenData>());
    });

    test('toData equality: result equals manually created TokenData', () {
      final data = tTokenEntity.toData();
      expect(data, tTokenData);
    });
  });

  group('Round-trip conversion', () {
    test('TokenData -> Token -> TokenData should preserve all values', () {
      final roundTripped = tTokenData.toEntity().toData();
      expect(roundTripped, tTokenData);
    });

    test('Token -> TokenData -> Token should preserve all values', () {
      final roundTripped = tTokenEntity.toData().toEntity();
      expect(roundTripped, tTokenEntity);
    });
  });
}