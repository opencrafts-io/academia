import 'dart:convert';
import 'dart:typed_data';

import 'package:academia/core/network/dio_client.dart';
import 'package:academia/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:academia/features/auth/data/models/token.dart';
import 'package:academia/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:academia/features/auth/data/repository/auth_repository_impl.dart';
import 'package:core/config/flavor.dart';
import 'package:dio/dio.dart';
import 'package:dio_request_inspector/dio_request_inspector.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_secure_storage/test/test_flutter_secure_storage_platform.dart';
import 'package:flutter_secure_storage_platform_interface/flutter_secure_storage_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Map<String, String> secureValues;
  late AuthLocalDatasource local;

  setUp(() {
    secureValues = {};
    FlutterSecureStoragePlatform.instance = TestFlutterSecureStoragePlatform(
      secureValues,
    );
    local = AuthLocalDatasource(storage: const FlutterSecureStorage());
  });

  test(
    'password sign-in normalizes email and persists one secure token pair',
    () async {
      late RequestOptions request;
      final client = _client(local, (options) async {
        request = options;
        return _jsonResponse(200, _tokenResponse('access-1', 'refresh-1'));
      });
      final repository = AuthRepositoryImpl(
        authRemoteDatasource: AuthRemoteDatasource(
          flavor: _flavor,
          dioClient: client,
        ),
        authLocalDatasource: local,
      );
      const password = '  pass😀word has spaces  ';

      final result = await repository.signInWithPassword(
        email: '  Reviewer@Example.COM  ',
        password: password,
      );

      expect(result.isRight(), isTrue);
      expect(request.path, '/qa-verisafe/auth/password/login');
      expect(request.data, {
        'email': 'reviewer@example.com',
        'password': password,
      });
      expect(secureValues.keys, {'token_verisafe'});
      final cached = jsonDecode(secureValues['token_verisafe']!) as Map;
      expect(cached['access_token'], 'access-1');
      expect(cached['refresh_token'], 'refresh-1');
      expect((await local.getTokenByProvider('verisafe')).isRight(), isTrue);
    },
  );

  test(
    'password login reaches Dio transport with the configured base URL',
    () async {
      late Uri requestUri;
      final client = DioClient(
        _flavor,
        authLocalDatasource: local,
        requestInspector: DioRequestInspector(isInspectorEnabled: true),
      );
      client.dio.httpClientAdapter = _TestAdapter((options) async {
        requestUri = options.uri;
        return _jsonResponse(200, _tokenResponse('access-1', 'refresh-1'));
      });
      final remote = AuthRemoteDatasource(flavor: _flavor, dioClient: client);

      final result = await remote.signInWithPassword(
        email: 'reviewer@example.com',
        password: 'a long enough password',
      );

      expect(result.isRight(), isTrue);
      expect(
        requestUri,
        Uri.parse('https://api.example.test/qa-verisafe/auth/password/login'),
      );
    },
  );

  test(
    'password sign-in maps every 401 to the same generic credential error',
    () async {
      for (final serverMessage in [
        'Email address was not found',
        'Password is incorrect',
      ]) {
        final client = _client(
          local,
          (_) async => _jsonResponse(401, {'error': serverMessage}),
        );
        final remote = AuthRemoteDatasource(flavor: _flavor, dioClient: client);

        final result = await remote.signInWithPassword(
          email: 'reviewer@example.com',
          password: 'long enough password',
        );

        expect(
          result
              .swap()
              .getOrElse(() => throw StateError('Expected sign-in failure'))
              .message,
          'Invalid email or password.',
        );
      }
    },
  );

  test('password sign-in explains rate limiting', () async {
    final client = _client(
      local,
      (_) async => _jsonResponse(429, {'error': 'Too many requests'}),
    );
    final remote = AuthRemoteDatasource(flavor: _flavor, dioClient: client);

    final result = await remote.signInWithPassword(
      email: 'reviewer@example.com',
      password: 'long enough password',
    );

    expect(
      result
          .swap()
          .getOrElse(() => throw StateError('Expected failure'))
          .message,
      contains('Too many sign-in attempts'),
    );
  });

  test(
    'password sign-in explains when the rate limiter is unavailable',
    () async {
      final client = _client(
        local,
        (_) async => _jsonResponse(503, {'error': 'temporarily unavailable'}),
      );
      final remote = AuthRemoteDatasource(flavor: _flavor, dioClient: client);

      final result = await remote.signInWithPassword(
        email: 'reviewer@example.com',
        password: 'long enough password',
      );

      expect(
        result
            .swap()
            .getOrElse(() => throw StateError('Expected failure'))
            .message,
        contains('temporarily unavailable'),
      );
    },
  );

  test(
    'unexpected authentication responses expose only the HTTP status',
    () async {
      final client = _client(
        local,
        (_) async => _jsonResponse(404, {'error': 'private backend detail'}),
      );
      final remote = AuthRemoteDatasource(flavor: _flavor, dioClient: client);

      final result = await remote.signInWithPassword(
        email: 'reviewer@example.com',
        password: 'long enough password',
      );

      final failure = result.swap().getOrElse(
        () => throw StateError('Expected sign-in failure'),
      );
      expect(failure.message, contains('HTTP 404'));
      expect(failure.message, isNot(contains('private backend detail')));
    },
  );

  test('password save accepts an empty HTTP 204 response', () async {
    late RequestOptions request;
    String? authorization;
    await local.cacheOrUpdateToken(
      _tokenData('signed-in-access', 'signed-in-refresh'),
    );
    final client = _client(local, (options) async {
      request = options;
      authorization = options.headers['Authorization'] as String?;
      return ResponseBody.fromString('', 204);
    });
    final remote = AuthRemoteDatasource(flavor: _flavor, dioClient: client);

    final result = await remote.setPassword('a new password with spaces');

    expect(
      result.isRight(),
      isTrue,
      reason: result.fold((failure) => failure.message, (_) => ''),
    );
    expect(request.path, '/qa-verisafe/auth/password');
    expect(request.data, {'password': 'a new password with spaces'});
    expect(authorization, 'Bearer signed-in-access');
    expect(request.headers.toString(), isNot(contains('signed-in-access')));
  });

  test(
    'logout revokes the current pair before clearing secure credentials',
    () async {
      late RequestOptions request;
      String? authorization;
      await local.cacheOrUpdateToken(
        _tokenData('signed-in-access', 'current-refresh'),
      );
      final client = _client(local, (options) async {
        request = options;
        authorization = options.headers['Authorization'] as String?;
        return ResponseBody.fromString('', 204);
      });
      final repository = AuthRepositoryImpl(
        authRemoteDatasource: AuthRemoteDatasource(
          flavor: _flavor,
          dioClient: client,
        ),
        authLocalDatasource: local,
      );

      final result = await repository.signout();

      expect(
        result.isRight(),
        isTrue,
        reason: result.fold((failure) => failure.message, (_) => ''),
      );
      expect(request.path, '/qa-verisafe/auth/token/revoke');
      expect(request.data, {'refresh_token': 'current-refresh'});
      expect(authorization, 'Bearer signed-in-access');
      expect(request.headers.toString(), isNot(contains('signed-in-access')));
      expect(secureValues, isEmpty);
    },
  );
}

final _flavor = FlavorConfig(
  flavor: Flavor.staging,
  appName: 'Academia',
  apiBaseUrl: 'https://api.example.test',
);

DioClient _client(
  AuthLocalDatasource local,
  Future<ResponseBody> Function(RequestOptions) respond,
) {
  final client = DioClient(
    _flavor,
    authLocalDatasource: local,
    requestInspector: null,
  );
  client.dio.httpClientAdapter = _TestAdapter(respond);
  return client;
}

TokenData _tokenData(String access, String refresh) => TokenData(
  provider: 'verisafe',
  accessToken: access,
  refreshToken: refresh,
  accessExpiresAt: DateTime.now().add(const Duration(hours: 1)),
  refreshExpiresAt: DateTime.now().add(const Duration(days: 1)),
);

Map<String, Object> _tokenResponse(String access, String refresh) => {
  'access_token': access,
  'refresh_token': refresh,
  'access_expires_at': DateTime.now()
      .add(const Duration(hours: 1))
      .toIso8601String(),
  'refresh_expires_at': DateTime.now()
      .add(const Duration(days: 30))
      .toIso8601String(),
};

ResponseBody _jsonResponse(int status, Object body) => ResponseBody.fromString(
  jsonEncode(body),
  status,
  headers: {
    Headers.contentTypeHeader: ['application/json'],
  },
);

class _TestAdapter implements HttpClientAdapter {
  _TestAdapter(this.respond);

  final Future<ResponseBody> Function(RequestOptions) respond;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) => respond(options);

  @override
  void close({bool force = false}) {}
}
