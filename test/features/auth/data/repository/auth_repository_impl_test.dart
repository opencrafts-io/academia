import 'package:academia/core/error/failures.dart';
import 'package:academia/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:academia/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:academia/features/auth/data/models/token.dart';
import 'package:academia/features/auth/data/repository/auth_repository_impl.dart';
import 'package:academia/features/auth/domain/entities/token.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDatasource extends Mock implements AuthRemoteDatasource {}

class MockAuthLocalDatasource extends Mock implements AuthLocalDatasource {}

void main() {
  late MockAuthRemoteDatasource mockRemote;
  late MockAuthLocalDatasource mockLocal;
  late AuthRepositoryImpl repository;

  final tAccessExpiresAt = DateTime.utc(2026, 6, 1, 12, 0, 0);
  final tRefreshExpiresAt = DateTime.utc(2026, 12, 1, 12, 0, 0);

  final tTokenData = TokenData(
    provider: 'verisafe',
    accessToken: 'access-token-123',
    refreshToken: 'refresh-token-456',
    accessExpiresAt: tAccessExpiresAt,
    refreshExpiresAt: tRefreshExpiresAt,
  );

  final tTokenEntity = Token(
    provider: 'verisafe',
    accessToken: 'access-token-123',
    refreshToken: 'refresh-token-456',
    accessExpiresAt: tAccessExpiresAt,
    refreshExpiresAt: tRefreshExpiresAt,
  );

  setUp(() {
    mockRemote = MockAuthRemoteDatasource();
    mockLocal = MockAuthLocalDatasource();
    repository = AuthRepositoryImpl(
      authRemoteDatasource: mockRemote,
      authLocalDatasource: mockLocal,
    );
  });

  group('AuthRepositoryImpl', () {
    group('signInWithProvider', () {
      test('should return Token when remote and local both succeed', () async {
        when(() => mockRemote.signInWithProvider(
              'google',
              deviceToken: 'device-123',
              deviceName: 'Pixel 7',
            )).thenAnswer((_) async => right(tTokenData));
        when(() => mockLocal.cacheOrUpdateToken(tTokenData))
            .thenAnswer((_) async => right(tTokenData));

        final result = await repository.signInWithProvider(
          'google',
          deviceToken: 'device-123',
          deviceName: 'Pixel 7',
        );

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Expected Right'),
          (token) => expect(token, tTokenEntity),
        );
      });

      test('should return Failure when remote datasource fails', () async {
        final failure = AuthenticationFailure(
          message: 'Auth cancelled',
          error: Exception('cancelled'),
        );
        when(() => mockRemote.signInWithProvider(
              any(),
              deviceToken: any(named: 'deviceToken'),
              deviceName: any(named: 'deviceName'),
            )).thenAnswer((_) async => left(failure));

        final result = await repository.signInWithProvider('google');

        expect(result.isLeft(), true);
        result.fold(
          (f) => expect(f, failure),
          (_) => fail('Expected Left'),
        );
        verifyNever(() => mockLocal.cacheOrUpdateToken(any()));
      });

      test('should return Failure when local caching fails after remote success',
          () async {
        final cacheFailure = CacheFailure(
          message: 'Cache error',
          error: Exception('disk full'),
        );
        when(() => mockRemote.signInWithProvider(
              any(),
              deviceToken: any(named: 'deviceToken'),
              deviceName: any(named: 'deviceName'),
            )).thenAnswer((_) async => right(tTokenData));
        when(() => mockLocal.cacheOrUpdateToken(tTokenData))
            .thenAnswer((_) async => left(cacheFailure));

        final result = await repository.signInWithProvider('google');

        expect(result.isLeft(), true);
        result.fold(
          (f) => expect(f, cacheFailure),
          (_) => fail('Expected Left'),
        );
      });

      test('should pass default deviceToken and deviceName when not provided',
          () async {
        when(() => mockRemote.signInWithProvider(
              'apple',
              deviceToken: 'none',
              deviceName: 'Unknown Device',
            )).thenAnswer((_) async => right(tTokenData));
        when(() => mockLocal.cacheOrUpdateToken(any()))
            .thenAnswer((_) async => right(tTokenData));

        await repository.signInWithProvider('apple');

        verify(() => mockRemote.signInWithProvider(
              'apple',
              deviceToken: 'none',
              deviceName: 'Unknown Device',
            )).called(1);
      });
    });

    group('getPreviousAuthState', () {
      test('should return list of Token entities on success', () async {
        when(() => mockLocal.getAllCachedTokens())
            .thenAnswer((_) async => right([tTokenData]));

        final result = await repository.getPreviousAuthState();

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Expected Right'),
          (tokens) {
            expect(tokens.length, 1);
            expect(tokens.first, tTokenEntity);
          },
        );
      });

      test('should return empty list when no tokens are cached', () async {
        when(() => mockLocal.getAllCachedTokens())
            .thenAnswer((_) async => right([]));

        final result = await repository.getPreviousAuthState();

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Expected Right'),
          (tokens) => expect(tokens, isEmpty),
        );
      });

      test('should return Failure when local datasource fails', () async {
        final failure = CacheFailure(
          message: 'Storage unavailable',
          error: Exception('io error'),
        );
        when(() => mockLocal.getAllCachedTokens())
            .thenAnswer((_) async => left(failure));

        final result = await repository.getPreviousAuthState();

        expect(result.isLeft(), true);
        result.fold(
          (f) => expect(f, failure),
          (_) => fail('Expected Left'),
        );
      });
    });

    group('refreshVerisafeToken', () {
      test('should return refreshed Token when remote and local succeed',
          () async {
        final newTokenData = TokenData(
          provider: 'verisafe',
          accessToken: 'new-access-token',
          refreshToken: 'new-refresh-token',
          accessExpiresAt: DateTime.utc(2026, 7, 1),
          refreshExpiresAt: DateTime.utc(2027, 1, 1),
        );

        when(() => mockRemote.refreshVerisafeToken(tTokenData))
            .thenAnswer((_) async => right(newTokenData));
        when(() => mockLocal.cacheOrUpdateToken(newTokenData))
            .thenAnswer((_) async => right(newTokenData));

        final result = await repository.refreshVerisafeToken(tTokenEntity);

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Expected Right'),
          (token) => expect(token.accessToken, 'new-access-token'),
        );
      });

      test('should return Failure when remote refresh fails', () async {
        final failure = AuthenticationFailure(
          message: 'Refresh failed',
          error: Exception('network error'),
        );
        when(() => mockRemote.refreshVerisafeToken(any()))
            .thenAnswer((_) async => left(failure));

        final result = await repository.refreshVerisafeToken(tTokenEntity);

        expect(result.isLeft(), true);
        verifyNever(() => mockLocal.cacheOrUpdateToken(any()));
      });

      test('should return Failure when local caching after refresh fails',
          () async {
        final cacheFailure = CacheFailure(
          message: 'Cannot write',
          error: Exception('storage error'),
        );
        final newTokenData = tTokenData.copyWith(accessToken: 'new-token');
        when(() => mockRemote.refreshVerisafeToken(any()))
            .thenAnswer((_) async => right(newTokenData));
        when(() => mockLocal.cacheOrUpdateToken(newTokenData))
            .thenAnswer((_) async => left(cacheFailure));

        final result = await repository.refreshVerisafeToken(tTokenEntity);

        expect(result.isLeft(), true);
        result.fold(
          (f) => expect(f, cacheFailure),
          (_) => fail('Expected Left'),
        );
      });
    });

    group('signout', () {
      test(
          'should revoke token remotely, delete all local tokens and return Right when verisafe token exists',
          () async {
        when(() => mockLocal.getTokenByProvider('verisafe'))
            .thenAnswer((_) async => right(tTokenData));
        when(() => mockRemote.revokeToken(tTokenData))
            .thenAnswer((_) async => right(tTokenData));
        when(() => mockLocal.deleteAllTokens())
            .thenAnswer((_) async => right(null));

        final result = await repository.signout();

        expect(result.isRight(), true);
        verify(() => mockLocal.deleteAllTokens()).called(1);
      });

      test(
          'should still delete all local tokens and return Right when no verisafe token found',
          () async {
        when(() => mockLocal.getTokenByProvider('verisafe'))
            .thenAnswer((_) async => left(NoDataFoundFailure(
                  message: 'not found',
                  error: Exception('missing'),
                )));
        when(() => mockLocal.deleteAllTokens())
            .thenAnswer((_) async => right(null));

        final result = await repository.signout();

        expect(result.isRight(), true);
        verify(() => mockLocal.deleteAllTokens()).called(1);
        verifyNever(() => mockRemote.revokeToken(any()));
      });
    });
  });
}