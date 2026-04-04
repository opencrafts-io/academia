import 'package:academia/config/flavor.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/core/network/dio_client.dart';
import 'package:academia/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:academia/features/auth/data/models/token.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthLocalDatasource extends Mock implements AuthLocalDatasource {}

/// A Dio HTTP adapter that captures the last request options for assertions.
class _CapturingAdapter implements HttpClientAdapter {
  RequestOptions? capturedOptions;
  final Map<String, dynamic> responseData;
  final int statusCode;

  _CapturingAdapter({this.responseData = const {}, this.statusCode = 200});

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    capturedOptions = options;
    return ResponseBody.fromString('{}', statusCode);
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  late MockAuthLocalDatasource mockLocalDatasource;
  late FlavorConfig tFlavor;

  final tAccessExpiresAt = DateTime.utc(2026, 6, 1, 12, 0, 0);
  final tRefreshExpiresAt = DateTime.utc(2026, 12, 1, 12, 0, 0);

  final tToken = TokenData(
    provider: 'verisafe',
    accessToken: 'my-access-token',
    refreshToken: 'my-refresh-token',
    accessExpiresAt: tAccessExpiresAt,
    refreshExpiresAt: tRefreshExpiresAt,
  );

  setUp(() {
    mockLocalDatasource = MockAuthLocalDatasource();
    tFlavor = FlavorConfig(
      flavor: Flavor.development,
      appName: 'Test App',
      apiBaseUrl: 'https://api.test.io',
    );
  });

  DioClient buildClient() => DioClient(
        tFlavor,
        authLocalDatasource: mockLocalDatasource,
        requestInspector: null,
      );

  group('DioClient auth interceptor', () {
    test(
        'should add Authorization header when a verisafe token is stored in local datasource',
        () async {
      when(() => mockLocalDatasource.getTokenByProvider('verisafe'))
          .thenAnswer((_) async => right(tToken));

      final client = buildClient();
      final adapter = _CapturingAdapter();
      client.dio.httpClientAdapter = adapter;

      try {
        await client.dio.get('/some-endpoint');
      } catch (_) {
        // Ignore response parsing errors - we only care about the request.
      }

      expect(
        adapter.capturedOptions?.headers['Authorization'],
        'Bearer my-access-token',
      );
    });

    test(
        'should not add Authorization header when no verisafe token is stored',
        () async {
      when(() => mockLocalDatasource.getTokenByProvider('verisafe'))
          .thenAnswer((_) async => left(NoDataFoundFailure(
                message: 'Token not found',
                error: Exception('not found'),
              )));

      final client = buildClient();
      final adapter = _CapturingAdapter();
      client.dio.httpClientAdapter = adapter;

      try {
        await client.dio.get('/some-endpoint');
      } catch (_) {}

      expect(
        adapter.capturedOptions?.headers.containsKey('Authorization'),
        isFalse,
      );
    });

    test('should skip auth entirely when skipAuth extra is true', () async {
      final client = buildClient();
      final adapter = _CapturingAdapter();
      client.dio.httpClientAdapter = adapter;

      try {
        await client.dio.get(
          '/public-endpoint',
          options: Options(extra: {'skipAuth': true}),
        );
      } catch (_) {}

      verifyNever(() => mockLocalDatasource.getTokenByProvider(any()));
      expect(
        adapter.capturedOptions?.headers.containsKey('Authorization'),
        isFalse,
      );
    });

    test('should call getTokenByProvider with verisafe provider', () async {
      when(() => mockLocalDatasource.getTokenByProvider('verisafe'))
          .thenAnswer((_) async => right(tToken));

      final client = buildClient();
      client.dio.httpClientAdapter = _CapturingAdapter();

      try {
        await client.dio.get('/endpoint');
      } catch (_) {}

      verify(() => mockLocalDatasource.getTokenByProvider('verisafe'))
          .called(1);
    });

    test('should not skip auth when skipAuth extra is false', () async {
      when(() => mockLocalDatasource.getTokenByProvider('verisafe'))
          .thenAnswer((_) async => right(tToken));

      final client = buildClient();
      final adapter = _CapturingAdapter();
      client.dio.httpClientAdapter = adapter;

      try {
        await client.dio.get(
          '/endpoint',
          options: Options(extra: {'skipAuth': false}),
        );
      } catch (_) {}

      verify(() => mockLocalDatasource.getTokenByProvider('verisafe'))
          .called(1);
    });

    test('should not skip auth when skipAuth extra key is absent', () async {
      when(() => mockLocalDatasource.getTokenByProvider('verisafe'))
          .thenAnswer((_) async => right(tToken));

      final client = buildClient();
      client.dio.httpClientAdapter = _CapturingAdapter();

      try {
        await client.dio.get('/endpoint');
      } catch (_) {}

      verify(() => mockLocalDatasource.getTokenByProvider('verisafe'))
          .called(1);
    });

    test('should configure baseUrl from the provided FlavorConfig', () {
      final prodFlavor = FlavorConfig(
        flavor: Flavor.production,
        appName: 'Prod',
        apiBaseUrl: 'https://api.production.io',
      );

      final client = DioClient(
        prodFlavor,
        authLocalDatasource: mockLocalDatasource,
        requestInspector: null,
      );

      expect(client.dio.options.baseUrl, 'https://api.production.io');
    });

    test('validateStatus should return true for status codes below 500', () {
      final client = buildClient();
      final validate = client.dio.options.validateStatus;

      expect(validate?.call(200), isTrue);
      expect(validate?.call(404), isTrue);
      expect(validate?.call(499), isTrue);
    });

    test('validateStatus should return false for status 500 and above', () {
      final client = buildClient();
      final validate = client.dio.options.validateStatus;

      // Note: validateStatus is status! < 500, so 500 returns false
      expect(validate?.call(500), isFalse);
      expect(validate?.call(503), isFalse);
    });
  });
}