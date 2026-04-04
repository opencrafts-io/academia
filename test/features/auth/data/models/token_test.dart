import 'package:flutter_test/flutter_test.dart';
import 'package:academia/features/auth/data/models/token.dart';

void main() {
  final tAccessExpiresAt = DateTime.utc(2026, 6, 1, 12, 0, 0);
  final tRefreshExpiresAt = DateTime.utc(2026, 12, 1, 12, 0, 0);

  final tTokenData = TokenData(
    provider: 'verisafe',
    accessToken: 'access-token-123',
    refreshToken: 'refresh-token-456',
    accessExpiresAt: tAccessExpiresAt,
    refreshExpiresAt: tRefreshExpiresAt,
  );

  group('TokenData', () {
    group('fromJson', () {
      test('should deserialize all fields correctly', () {
        final json = {
          'verisafe': 'verisafe',
          'access_token': 'access-token-123',
          'refresh_token': 'refresh-token-456',
          'access_expires_at': '2026-06-01T12:00:00.000Z',
          'refresh_expires_at': '2026-12-01T12:00:00.000Z',
        };

        final result = TokenData.fromJson(json);

        expect(result.provider, 'verisafe');
        expect(result.accessToken, 'access-token-123');
        expect(result.refreshToken, 'refresh-token-456');
        expect(result.accessExpiresAt, DateTime.parse('2026-06-01T12:00:00.000Z'));
        expect(result.refreshExpiresAt, DateTime.parse('2026-12-01T12:00:00.000Z'));
      });

      test('should throw FormatException when access_expires_at is null', () {
        final json = {
          'verisafe': 'verisafe',
          'access_token': 'access-token-123',
          'refresh_token': 'refresh-token-456',
          'access_expires_at': null,
          'refresh_expires_at': '2026-12-01T12:00:00.000Z',
        };

        expect(() => TokenData.fromJson(json), throwsA(isA<FormatException>()));
      });

      test('should throw FormatException when refresh_expires_at is null', () {
        final json = {
          'verisafe': 'verisafe',
          'access_token': 'access-token-123',
          'refresh_token': 'refresh-token-456',
          'access_expires_at': '2026-06-01T12:00:00.000Z',
          'refresh_expires_at': null,
        };

        expect(() => TokenData.fromJson(json), throwsA(isA<FormatException>()));
      });

      test('should throw when access_expires_at has invalid date format', () {
        final json = {
          'verisafe': 'verisafe',
          'access_token': 'access-token-123',
          'refresh_token': 'refresh-token-456',
          'access_expires_at': 'not-a-date',
          'refresh_expires_at': '2026-12-01T12:00:00.000Z',
        };

        expect(() => TokenData.fromJson(json), throwsA(anything));
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        final result = tTokenData.toJson();

        expect(result['verisafe'], 'verisafe');
        expect(result['access_token'], 'access-token-123');
        expect(result['refresh_token'], 'refresh-token-456');
        expect(result['access_expires_at'], tAccessExpiresAt.toIso8601String());
        expect(result['refresh_expires_at'], tRefreshExpiresAt.toIso8601String());
      });

      test('toJson output should be deserializable back to the same object', () {
        final json = tTokenData.toJson();
        final result = TokenData.fromJson(json);
        expect(result, tTokenData);
      });
    });

    group('equality', () {
      test('two instances with same values should be equal', () {
        final other = TokenData(
          provider: 'verisafe',
          accessToken: 'access-token-123',
          refreshToken: 'refresh-token-456',
          accessExpiresAt: tAccessExpiresAt,
          refreshExpiresAt: tRefreshExpiresAt,
        );
        expect(tTokenData, other);
      });

      test('instances with different accessToken should not be equal', () {
        final other = tTokenData.copyWith(accessToken: 'different-access');
        expect(tTokenData, isNot(other));
      });

      test('instances with different provider should not be equal', () {
        final other = tTokenData.copyWith(provider: 'google');
        expect(tTokenData, isNot(other));
      });

      test('instances with different refreshToken should not be equal', () {
        final other = tTokenData.copyWith(refreshToken: 'different-refresh');
        expect(tTokenData, isNot(other));
      });

      test('instances with different accessExpiresAt should not be equal', () {
        final other = tTokenData.copyWith(
          accessExpiresAt: DateTime.utc(2027, 1, 1),
        );
        expect(tTokenData, isNot(other));
      });
    });

    group('copyWith', () {
      test('should return a new instance with updated accessToken', () {
        final updated = tTokenData.copyWith(accessToken: 'new-access');
        expect(updated.accessToken, 'new-access');
        expect(updated.provider, tTokenData.provider);
        expect(updated.refreshToken, tTokenData.refreshToken);
        expect(updated.accessExpiresAt, tTokenData.accessExpiresAt);
        expect(updated.refreshExpiresAt, tTokenData.refreshExpiresAt);
      });

      test('should return identical values when no field is changed', () {
        final copy = tTokenData.copyWith();
        expect(copy, tTokenData);
      });

      test('should correctly update refreshExpiresAt', () {
        final newExpiry = DateTime.utc(2027, 6, 1);
        final updated = tTokenData.copyWith(refreshExpiresAt: newExpiry);
        expect(updated.refreshExpiresAt, newExpiry);
        expect(updated.accessToken, tTokenData.accessToken);
      });
    });

    group('hashCode', () {
      test('equal objects should have equal hashCodes', () {
        final other = TokenData(
          provider: 'verisafe',
          accessToken: 'access-token-123',
          refreshToken: 'refresh-token-456',
          accessExpiresAt: tAccessExpiresAt,
          refreshExpiresAt: tRefreshExpiresAt,
        );
        expect(tTokenData.hashCode, other.hashCode);
      });
    });

    group('toString', () {
      test('should include all field values', () {
        final str = tTokenData.toString();
        expect(str, contains('verisafe'));
        expect(str, contains('access-token-123'));
        expect(str, contains('refresh-token-456'));
      });
    });
  });
}