import 'dart:convert';
import 'dart:typed_data';

import 'package:academia/core/network/dio_client.dart';
import 'package:academia/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:academia/features/auth/data/models/token.dart';
import 'package:core/config/flavor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_secure_storage/test/test_flutter_secure_storage_platform.dart';
import 'package:flutter_secure_storage_platform_interface/flutter_secure_storage_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AuthLocalDatasource local;

  setUp(() {
    FlutterSecureStoragePlatform.instance = TestFlutterSecureStoragePlatform(
      {},
    );
    local = AuthLocalDatasource(storage: const FlutterSecureStorage());
  });

  test(
    'a request without a Verisafe session reaches transport unauthenticated',
    () async {
      var transportReached = false;
      final client = _client(local, (options) async {
        transportReached = true;
        expect(options.headers['Authorization'], isNull);
        return _jsonResponse(200, {'ok': true});
      });

      final response = await client.dio.get('/public');

      expect(transportReached, isTrue);
      expect(response.statusCode, 200);
    },
  );

  test(
    'a transient refresh failure does not block the original request',
    () async {
      var refreshRequests = 0;
      var protectedRequests = 0;
      await local.cacheOrUpdateToken(
        _token(
          access: 'expired-access',
          refresh: 'usable-refresh',
          accessExpiry: DateTime.now().subtract(const Duration(seconds: 1)),
        ),
      );
      final client = _client(local, (options) async {
        if (options.path == '/qa-verisafe/auth/token/refresh') {
          refreshRequests++;
          throw DioException(
            requestOptions: options,
            type: DioExceptionType.connectionError,
          );
        }
        protectedRequests++;
        expect(options.headers['Authorization'], 'Bearer expired-access');
        return _jsonResponse(200, {'ok': true});
      });

      final response = await client.dio.get('/protected');

      expect(response.statusCode, 200);
      expect(refreshRequests, 1);
      expect(protectedRequests, 1);
    },
  );

  test(
    'concurrent expired-token requests share one refresh and rotate the pair',
    () async {
      var refreshRequests = 0;
      await local.cacheOrUpdateToken(
        _token(
          access: 'old-access',
          refresh: 'old-refresh',
          accessExpiry: DateTime.now().subtract(const Duration(seconds: 1)),
        ),
      );
      final client = _client(local, (options) async {
        if (options.path == '/qa-verisafe/auth/token/refresh') {
          refreshRequests++;
          expect(options.data, {'refresh_token': 'old-refresh'});
          await Future<void>.delayed(const Duration(milliseconds: 10));
          return _tokens('new-access', 'new-refresh');
        }
        expect(options.headers['Authorization'], 'Bearer new-access');
        return ResponseBody.fromString('{}', 200);
      });

      final responses = await Future.wait([
        client.dio.get('/protected/a'),
        client.dio.get('/protected/b'),
      ]);

      expect(responses.map((response) => response.statusCode), [200, 200]);
      expect(refreshRequests, 1);
      final stored = (await local.getTokenByProvider('verisafe'))
          .getOrElse(() => throw StateError('Expected rotated token pair'));
      expect(stored.accessToken, 'new-access');
      expect(stored.refreshToken, 'new-refresh');
    },
  );

  test('production refresh requests use the verisafe service path', () async {
    late RequestOptions refreshRequest;
    await local.cacheOrUpdateToken(
      _token(
        access: 'expired-access',
        refresh: 'usable-refresh',
        accessExpiry: DateTime.now().subtract(const Duration(seconds: 1)),
      ),
    );
    final client = _client(
      local,
      (options) async {
        if (options.path == '/verisafe/auth/token/refresh') {
          refreshRequest = options;
          return _tokens('new-access', 'new-refresh');
        }
        return _jsonResponse(200, {'ok': true});
      },
      flavor: FlavorConfig(
        flavor: Flavor.production,
        appName: 'Academia',
        apiBaseUrl: 'https://api.example.test',
      ),
    );

    await client.dio.get('/protected');

    expect(refreshRequest.uri.path, '/verisafe/auth/token/refresh');
    expect(
      refreshRequest.uri,
      Uri.parse('https://api.example.test/verisafe/auth/token/refresh'),
    );
  });

  test(
    'a request that still receives 401 after refresh is retried only once',
    () async {
      var protectedRequests = 0;
      var refreshRequests = 0;
      await local.cacheOrUpdateToken(
        _token(
          access: 'current-access',
          refresh: 'current-refresh',
          accessExpiry: DateTime.now().add(const Duration(hours: 1)),
        ),
      );
      final client = _client(local, (options) async {
        if (options.path == '/qa-verisafe/auth/token/refresh') {
          refreshRequests++;
          return _tokens('rotated-access', 'rotated-refresh');
        }
        protectedRequests++;
        return _jsonResponse(401, {'error': 'unauthorized'});
      });

      final response = await client.dio.get('/protected');

      expect(response.statusCode, 401);
      expect(protectedRequests, 2);
      expect(refreshRequests, 1);
    },
  );

  test(
    'a rejected refresh clears credentials and signals the auth session',
    () async {
      var refreshRequests = 0;
      await local.cacheOrUpdateToken(
        _token(
          access: 'expired-access',
          refresh: 'rejected-refresh',
          accessExpiry: DateTime.now().subtract(const Duration(seconds: 1)),
        ),
      );
      final client = _client(local, (options) async {
        if (options.path == '/qa-verisafe/auth/token/refresh') {
          refreshRequests++;
          return _jsonResponse(401, {'error': 'invalid refresh token'});
        }
        fail(
          'The protected request must not be sent without valid credentials.',
        );
      });
      var invalidationEvents = 0;
      final subscription = local.sessionInvalidated.listen((_) {
        invalidationEvents++;
      });

      await expectLater(
        client.dio.get('/protected'),
        throwsA(isA<DioException>()),
      );
      await Future<void>.delayed(Duration.zero);
      await subscription.cancel();

      expect(refreshRequests, 1);
      expect(invalidationEvents, 1);
      expect((await local.getTokenByProvider('verisafe')).isLeft(), isTrue);
    },
  );

  test(
    'failed authenticated requests do not retain bearer tokens in errors',
    () async {
      String? sentAuthorization;
      await local.cacheOrUpdateToken(
        _token(
          access: 'access-secret',
          refresh: 'refresh-secret',
          accessExpiry: DateTime.now().add(const Duration(hours: 1)),
        ),
      );
      final client = _client(local, (options) async {
        sentAuthorization = options.headers['Authorization'] as String?;
        return _jsonResponse(500, {'error': 'server error'});
      });

      DioException? failure;
      try {
        await client.dio.get('/protected');
      } on DioException catch (error) {
        failure = error;
      }

      expect(sentAuthorization, 'Bearer access-secret');
      expect(failure, isNotNull);
      expect(failure.toString(), isNot(contains('access-secret')));
      expect(failure.toString(), isNot(contains('refresh-secret')));
      expect(
        failure!.requestOptions.headers.toString(),
        isNot(contains('access-secret')),
      );
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
  Future<ResponseBody> Function(RequestOptions) respond, {
  FlavorConfig? flavor,
}) {
  final client = DioClient(
    flavor ?? _flavor,
    authLocalDatasource: local,
    requestInspector: null,
  );
  client.dio.httpClientAdapter = _TestAdapter(respond);
  return client;
}

TokenData _token({
  required String access,
  required String refresh,
  required DateTime accessExpiry,
}) => TokenData(
  provider: 'verisafe',
  accessToken: access,
  refreshToken: refresh,
  accessExpiresAt: accessExpiry,
  refreshExpiresAt: DateTime.now().add(const Duration(days: 1)),
);

ResponseBody _tokens(String access, String refresh) => _jsonResponse(200, {
  'access_token': access,
  'refresh_token': refresh,
  'access_expires_at': DateTime.now()
      .add(const Duration(hours: 1))
      .toIso8601String(),
  'refresh_expires_at': DateTime.now()
      .add(const Duration(days: 30))
      .toIso8601String(),
});

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
