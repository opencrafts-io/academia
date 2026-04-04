import 'dart:convert';

import 'package:academia/core/error/failures.dart';
import 'package:academia/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:academia/features/auth/data/models/token.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockFlutterSecureStorage mockStorage;
  late AuthLocalDatasource datasource;

  final tAccessExpiresAt = DateTime.utc(2026, 6, 1, 12, 0, 0);
  final tRefreshExpiresAt = DateTime.utc(2026, 12, 1, 12, 0, 0);

  final tToken = TokenData(
    provider: 'verisafe',
    accessToken: 'access-token-123',
    refreshToken: 'refresh-token-456',
    accessExpiresAt: tAccessExpiresAt,
    refreshExpiresAt: tRefreshExpiresAt,
  );

  final tTokenKey = 'token_verisafe';
  final tTokenJson = jsonEncode(tToken.toJson());

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    datasource = AuthLocalDatasource(storage: mockStorage);
  });

  group('AuthLocalDatasource', () {
    group('cacheOrUpdateToken', () {
      test('should write token to secure storage and return it on success',
          () async {
        when(() => mockStorage.write(key: tTokenKey, value: tTokenJson))
            .thenAnswer((_) async {});

        final result = await datasource.cacheOrUpdateToken(tToken);

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Expected Right'),
          (token) => expect(token, tToken),
        );
        verify(() => mockStorage.write(key: tTokenKey, value: tTokenJson))
            .called(1);
      });

      test('should return CacheFailure when storage.write throws', () async {
        when(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')))
            .thenThrow(Exception('storage error'));

        final result = await datasource.cacheOrUpdateToken(tToken);

        expect(result.isLeft(), true);
        result.fold(
          (failure) => expect(failure, isA<CacheFailure>()),
          (_) => fail('Expected Left'),
        );
      });

      test('should use provider-based key prefix token_<provider>', () async {
        when(() => mockStorage.write(key: 'token_verisafe', value: any(named: 'value')))
            .thenAnswer((_) async {});

        await datasource.cacheOrUpdateToken(tToken);

        verify(() => mockStorage.write(
          key: 'token_verisafe',
          value: any(named: 'value'),
        )).called(1);
      });
    });

    group('getTokenByProvider', () {
      test('should return TokenData when key exists in secure storage',
          () async {
        when(() => mockStorage.read(key: tTokenKey))
            .thenAnswer((_) async => tTokenJson);

        final result = await datasource.getTokenByProvider('verisafe');

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Expected Right'),
          (token) => expect(token, tToken),
        );
      });

      test('should return NoDataFoundFailure when key does not exist',
          () async {
        when(() => mockStorage.read(key: tTokenKey))
            .thenAnswer((_) async => null);

        final result = await datasource.getTokenByProvider('verisafe');

        expect(result.isLeft(), true);
        result.fold(
          (failure) => expect(failure, isA<NoDataFoundFailure>()),
          (_) => fail('Expected Left'),
        );
      });

      test('should return CacheFailure when storage.read throws', () async {
        when(() => mockStorage.read(key: any(named: 'key')))
            .thenThrow(Exception('read error'));

        final result = await datasource.getTokenByProvider('verisafe');

        expect(result.isLeft(), true);
        result.fold(
          (failure) => expect(failure, isA<CacheFailure>()),
          (_) => fail('Expected Left'),
        );
      });

      test('should build key as token_<provider>', () async {
        when(() => mockStorage.read(key: 'token_google'))
            .thenAnswer((_) async => null);

        await datasource.getTokenByProvider('google');

        verify(() => mockStorage.read(key: 'token_google')).called(1);
      });
    });

    group('getAllCachedTokens', () {
      test('should return all tokens whose keys start with token_', () async {
        final tToken2 = TokenData(
          provider: 'google',
          accessToken: 'access-google',
          refreshToken: 'refresh-google',
          accessExpiresAt: tAccessExpiresAt,
          refreshExpiresAt: tRefreshExpiresAt,
        );

        when(() => mockStorage.readAll()).thenAnswer((_) async => {
              'token_verisafe': tTokenJson,
              'token_google': jsonEncode(tToken2.toJson()),
              'unrelated_key': 'some-value',
            });

        final result = await datasource.getAllCachedTokens();

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Expected Right'),
          (tokens) {
            expect(tokens.length, 2);
            expect(tokens, containsAll([tToken, tToken2]));
          },
        );
      });

      test('should return empty list when no token keys exist', () async {
        when(() => mockStorage.readAll())
            .thenAnswer((_) async => {'some_other_key': 'value'});

        final result = await datasource.getAllCachedTokens();

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Expected Right'),
          (tokens) => expect(tokens, isEmpty),
        );
      });

      test('should return CacheFailure when readAll throws', () async {
        when(() => mockStorage.readAll())
            .thenThrow(Exception('storage unavailable'));

        final result = await datasource.getAllCachedTokens();

        expect(result.isLeft(), true);
        result.fold(
          (failure) => expect(failure, isA<CacheFailure>()),
          (_) => fail('Expected Left'),
        );
      });

      test('should filter out non-token keys correctly', () async {
        when(() => mockStorage.readAll()).thenAnswer((_) async => {
              'session_id': 'abc',
              'user_prefs': '{}',
              'token_verisafe': tTokenJson,
            });

        final result = await datasource.getAllCachedTokens();

        result.fold(
          (_) => fail('Expected Right'),
          (tokens) => expect(tokens.length, 1),
        );
      });
    });

    group('deleteAllTokens', () {
      test('should delete all keys starting with token_ and return Right(null)',
          () async {
        when(() => mockStorage.readAll()).thenAnswer((_) async => {
              'token_verisafe': tTokenJson,
              'token_google': 'some-json',
              'other_key': 'value',
            });
        when(() => mockStorage.delete(key: 'token_verisafe'))
            .thenAnswer((_) async {});
        when(() => mockStorage.delete(key: 'token_google'))
            .thenAnswer((_) async {});

        final result = await datasource.deleteAllTokens();

        expect(result.isRight(), true);
        verify(() => mockStorage.delete(key: 'token_verisafe')).called(1);
        verify(() => mockStorage.delete(key: 'token_google')).called(1);
        verifyNever(() => mockStorage.delete(key: 'other_key'));
      });

      test('should not call delete when no token keys exist', () async {
        when(() => mockStorage.readAll())
            .thenAnswer((_) async => {'unrelated': 'data'});

        final result = await datasource.deleteAllTokens();

        expect(result.isRight(), true);
        verifyNever(() => mockStorage.delete(key: any(named: 'key')));
      });

      test('should return CacheFailure when readAll throws', () async {
        when(() => mockStorage.readAll())
            .thenThrow(Exception('storage error'));

        final result = await datasource.deleteAllTokens();

        expect(result.isLeft(), true);
        result.fold(
          (failure) => expect(failure, isA<CacheFailure>()),
          (_) => fail('Expected Left'),
        );
      });
    });

    group('deleteTokenByProvider', () {
      test('should delete token for the given provider and return Right(null)',
          () async {
        when(() => mockStorage.delete(key: 'token_verisafe'))
            .thenAnswer((_) async {});

        final result = await datasource.deleteTokenByProvider('verisafe');

        expect(result.isRight(), true);
        verify(() => mockStorage.delete(key: 'token_verisafe')).called(1);
      });

      test('should only delete the key for the specified provider', () async {
        when(() => mockStorage.delete(key: 'token_google'))
            .thenAnswer((_) async {});

        await datasource.deleteTokenByProvider('google');

        verify(() => mockStorage.delete(key: 'token_google')).called(1);
        verifyNever(() => mockStorage.delete(key: 'token_verisafe'));
      });

      test('should return CacheFailure when storage.delete throws', () async {
        when(() => mockStorage.delete(key: any(named: 'key')))
            .thenThrow(Exception('delete failed'));

        final result = await datasource.deleteTokenByProvider('verisafe');

        expect(result.isLeft(), true);
        result.fold(
          (failure) => expect(failure, isA<CacheFailure>()),
          (_) => fail('Expected Left'),
        );
      });

      test('should use correct key format token_<provider>', () async {
        when(() => mockStorage.delete(key: 'token_qa-verisafe'))
            .thenAnswer((_) async {});

        await datasource.deleteTokenByProvider('qa-verisafe');

        verify(() => mockStorage.delete(key: 'token_qa-verisafe')).called(1);
      });
    });
  });
}